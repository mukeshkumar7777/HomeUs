import 'package:flutter/material.dart';
import 'search_filter.dart';
import 'filter_screen.dart';
import 'filter_status_bar.dart';
import 'house_data.dart';
import 'house_card.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _allProperties = [];
  List<Map<String, dynamic>> _filteredProperties = [];

  // Filter states
  Map<String, dynamic>? _appliedFilters;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProperties();
    _searchController.addListener(_onSearchChanged);
  }

  void _loadProperties() {
    final houseData = HouseData.getHouseData();
    _allProperties = [];
    houseData.forEach((category, properties) {
      _allProperties.addAll(properties as List<Map<String, dynamic>>);
    });
    _applyFilters();
  }

  void _onSearchChanged() {
    _searchQuery = _searchController.text.toLowerCase();
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      _filteredProperties = _allProperties.where((property) {
        // Search filter
        final matchesSearch = _searchQuery.isEmpty ||
            property['title'].toLowerCase().contains(_searchQuery) ||
            property['location'].toLowerCase().contains(_searchQuery);

        if (!matchesSearch) return false;

        // Applied filters
        if (_appliedFilters == null) return true;

        final transactionType = _appliedFilters!['transactionType'] ?? 'Rent';
        final categoryType = _appliedFilters!['categoryType'] ?? 'Residential';
        final selectedPropertyType = _appliedFilters!['selectedPropertyType'];
        final minPrice = _appliedFilters!['minPrice'] ?? 0;
        final maxPrice = _appliedFilters!['maxPrice'] ?? 10000000;

        // Category filter
        if (property['category'] != categoryType) return false;

        // Property type filter
        if (selectedPropertyType != null && property['propertyType'] != selectedPropertyType) return false;

        // Price filter
        final price = transactionType == 'Rent' ? property['rentPrice'] : property['buyPrice'];
        if (price < minPrice || price > maxPrice) return false;

        return true;
      }).toList();
    });
  }

  void _openFilterScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FilterScreen()),
    );

    if (result != null) {
      setState(() {
        _appliedFilters = result;
      });
      _applyFilters();
    }
  }

  void _clearFilters() {
    setState(() {
      _appliedFilters = null;
    });
    _applyFilters();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasFilters = _appliedFilters != null;
    final transactionType = _appliedFilters?['transactionType'] ?? 'Rent';

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Properties'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.filter_list,
              color: hasFilters ? Theme.of(context).colorScheme.primary : null,
            ),
            onPressed: _openFilterScreen,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchFilterBar(
              controller: _searchController,
            ),
          ),
          if (hasFilters)
            FilterStatusBar(
              resultCount: _filteredProperties.length,
              onClearFilters: _clearFilters,
            ),
          Expanded(
            child: _filteredProperties.isEmpty
                ? const Center(
                    child: Text('No properties found'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _filteredProperties.length,
                    itemBuilder: (context, index) {
                      final property = _filteredProperties[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: HouseCard(
                          house: property,
                          transactionType: transactionType,
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:homeus/chips.dart';
import 'package:homeus/search_filter.dart';
import 'package:homeus/house_card.dart';
import 'package:homeus/filter_status_bar.dart';
import 'package:homeus/empty_state.dart';
import 'package:homeus/house_data.dart';
import 'package:homeus/filter_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _SearchHomeScreenState();
}

class _SearchHomeScreenState extends State<HomeScreen> {
  String selectedCategory = "Recently Watched";
  final houseData = HouseData.getHouseData();

  void onCategorySelected(String category) {
    setState(() {
      selectedCategory = category;
    });
  }

  Map<String, dynamic>? activeFilters;

  List<Map<String, dynamic>> _applyFilters() {
    List<Map<String, dynamic>> allHouses = [];
    
    // Get all houses from all categories
    for (var houses in houseData.values) {
      allHouses.addAll(houses.cast<Map<String, dynamic>>());
    }

    if (activeFilters == null) {
      // Return houses from selected category only
      return houseData[selectedCategory]?.cast<Map<String, dynamic>>() ?? [];
    }

    return allHouses.where((house) {
      // Filter by transaction type (Buy/Rent)
      final transactionType = activeFilters!["transactionType"] as String?;
      if (transactionType != null) {
        if (transactionType == "Rent" && house["rentPrice"] == null) return false;
        if (transactionType == "Buy" && house["buyPrice"] == null) return false;
      }

      // Filter by category type (Residential/Commercial)
      final categoryType = activeFilters!["categoryType"] as String?;
      if (categoryType != null && house["category"] != categoryType) return false;

      // Filter by property type
      final selectedPropertyType = activeFilters!["selectedPropertyType"] as String?;
      if (selectedPropertyType != null && house["propertyType"] != selectedPropertyType) return false;

      // Filter by price range
      final minPrice = activeFilters!["minPrice"] as int? ?? 0;
      final maxPrice = activeFilters!["maxPrice"] as int? ?? 1000000;
      
      final transactionTypeFilter = activeFilters!["transactionType"] as String?;
      int housePrice = 0;
      
      if (transactionTypeFilter == "Rent") {
        housePrice = house["rentPrice"] ?? 0;
      } else if (transactionTypeFilter == "Buy") {
        housePrice = house["buyPrice"] ?? 0;
      } else {
        // If no transaction type specified, check both rent and buy prices
        final rentPrice = house["rentPrice"] ?? 0;
        final buyPrice = house["buyPrice"] ?? 0;
        housePrice = rentPrice > 0 ? rentPrice : buyPrice;
      }

      if (housePrice < minPrice || housePrice > maxPrice) return false;

      // Filter by availability
      if (!house["isAvailable"]) return false;

      return true;
    }).toList();
  }

  Future<void> _openFilters() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const FilterScreen()),
    );
    if (result is Map<String, dynamic>) {
      setState(() {
        activeFilters = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentHouses = _applyFilters();

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'HomeUs',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.amber[300],
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Expanded(child: SearchFilterBar()),
                const SizedBox(width: 8),
                IconButton(
                  tooltip: 'Filters',
                  onPressed: _openFilters,
                  icon: const Icon(Icons.tune),
                ),
              ],
            ),
            const SizedBox(height: 20),
            CategoryChips(
              onCategorySelected: onCategorySelected,
              selected: selectedCategory,
            ),
            const SizedBox(height: 20),
            // Show filter status if filters are applied
            if (activeFilters != null)
              FilterStatusBar(
                resultCount: currentHouses.length,
                onClearFilters: () {
                  setState(() {
                    activeFilters = null;
                  });
                },
              ),
            Expanded(
              child: currentHouses.isEmpty
                  ? const EmptyState()
                  : ListView.builder(
                      itemCount: currentHouses.length,
                      itemBuilder: (context, index) {
                        final house = currentHouses[index];
                        return HouseCard(
                          house: house,
                          transactionType: activeFilters?["transactionType"] as String?,
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _properties = [
    {
      'title': 'Cozy Apartment',
      'location': 'Hyderabad',
      'price': 15000.0,
    },
    {
      'title': 'Modern Flat',
      'location': 'Kakinada',
      'price': 20000.0,
    },
  ];
  List<Map<String, dynamic>> _filteredProperties = [];

  @override
  void initState() {
    super.initState();
    _filteredProperties = _properties;
    _searchController.addListener(_filterProperties);
  }

  void _filterProperties() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredProperties = _properties.where((property) {
        return property['title'].toLowerCase().contains(query) ||
               property['location'].toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Properties'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by title or location...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredProperties.length,
              itemBuilder: (context, index) {
                final property = _filteredProperties[index];
                return ListTile(
                  title: Text(property['title']),
                  subtitle: Text('${property['location']} - ₹${property['price']}'),
                  onTap: () {
                    // TODO: Navigate to property details
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

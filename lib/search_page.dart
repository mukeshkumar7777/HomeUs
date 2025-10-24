import 'dart:async';
import 'package:flutter/material.dart';
import 'city_service.dart';
import 'map_screen.dart';
import 'listing_card.dart';
import 'filter_screen.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _controller = TextEditingController();
  Timer? _debounce;
  final List<String> _recent = <String>['2BHK near Vijayawada', 'Hostel in Guntur', 'PG in Tirupati'];
  List<City> _cityResults = [];
  final List<String> _categories = ['Houses', 'Hostels', 'PGs', 'Commercial'];
  String _selectedCategory = 'Houses';

  @override
  void dispose() {
    _debounce?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _onChanged(String text) {
    _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 350), () {
      final q = text.trim();
      if (q.isEmpty) {
        setState(() => _cityResults = []);
        return;
      }
      setState(() {
        _cityResults = CityService.searchAndhraPradeshCities(q);
      });
    });
  }

  void _navigateToMapWithCity(City city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(selectedCity: city),
      ),
    );
  }

  void _navigateToMapWithCategory(String category) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MapScreen(selectedCategory: category),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(0xFFF7C948),
        foregroundColor: Colors.black,
        title: const Text('Search Properties'),
        actions: [
          IconButton(
            tooltip: 'Map',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const MapScreen()));
            },
            icon: const Icon(Icons.map, color: Colors.black),
          ),
          IconButton(
            tooltip: 'Filter',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const FilterScreen()));
            },
            icon: const Icon(Icons.filter_list, color: Colors.black),
          ),
        ],
      ),
      body: Column(
        children: [
          // Enhanced Search Bar
          Container(
            padding: const EdgeInsets.all(16),
            color: Colors.amber[600],
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(28),
              ),
              child: TextField(
                controller: _controller,
                onChanged: _onChanged,
                decoration: const InputDecoration(
                  hintText: 'Search houses, rooms..',
                  prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                ),
                onSubmitted: (v) {
                  if (_cityResults.isNotEmpty) _navigateToMapWithCity(_cityResults.first);
                },
              ),
            ),
          ),
          // Content Area
          Expanded(
            child: _controller.text.isEmpty
                ? _buildListingLikeScreenshot()
                : _buildSearchResults(),
          ),
        ],
      ),
    );
  }

  Widget _buildListingLikeScreenshot() {
    final cards = List.generate(6, (i) => ListingCard(
      title: 'Modern Downtown Loft',
      price: i.isEven ? '₹23,000/month' : '₹25,000/month',
      subtitle: 'Downtown LA, CA',
      tags: const ['City Views', 'Rooftop Access', 'Gym'],
      assetImage: 'lib/assets/house${(i % 12) + 1}.jpg',
    ));
    return ListView(children: cards);
  }

  Widget _buildQuickAccessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Access',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildQuickAccessCard(
                'Near Me',
                Icons.my_location,
                Colors.orange,
                () => _navigateToMapWithCategory('Houses'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickAccessCard(
                'Budget Friendly',
                Icons.attach_money,
                Colors.green,
                () => _navigateToMapWithCategory('PGs'),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _buildQuickAccessCard(
                'Student Housing',
                Icons.school,
                Colors.purple,
                () => _navigateToMapWithCategory('Hostels'),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _buildQuickAccessCard(
                'Commercial',
                Icons.business,
                Colors.blue,
                () => _navigateToMapWithCategory('Commercial'),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickAccessCard(String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentSearches() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Recent Searches',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: _recent.map((search) => _buildSearchChip(search)).toList(),
        ),
      ],
    );
  }

  Widget _buildSearchChip(String search) {
    return GestureDetector(
      onTap: () {
        _controller.text = search;
        _onChanged(search);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.grey[300]!),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.history, size: 16, color: Colors.grey[600]),
            const SizedBox(width: 6),
            Text(
              search,
              style: TextStyle(color: Colors.grey[700]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPopularCities() {
    final cities = CityService.getAndhraPradeshCities().take(6).toList();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Popular in Andhra Pradesh',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        ...cities.map((city) => _buildCityCard(city)).toList(),
      ],
    );
  }

  Widget _buildCityCard(City city) {
    return GestureDetector(
      onTap: () => _navigateToMapWithCity(city),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.amber[50],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(Icons.location_on, color: Colors.amber[700], size: 20),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    city.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    city.country,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Icon(Icons.arrow_forward_ios, color: Colors.amber[400], size: 16),
          ],
        ),
      ),
    );
  }

  Widget _buildFeaturesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Why Choose Us?',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        _buildFeatureItem(Icons.verified, 'Verified Properties', 'All properties are verified and authentic'),
        _buildFeatureItem(Icons.security, 'Secure Payments', 'Safe and secure payment options'),
        _buildFeatureItem(Icons.support_agent, '24/7 Support', 'Round the clock customer support'),
        _buildFeatureItem(Icons.map, 'Interactive Map', 'Find properties on our interactive map'),
      ],
    );
  }

  Widget _buildFeatureItem(IconData icon, String title, String subtitle) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: Colors.green[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: Colors.green[600], size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchResults() {
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemBuilder: (context, index) {
        if (index < _cityResults.length) {
          final city = _cityResults[index];
          return _buildCityCard(city);
        }
        return const SizedBox.shrink();
      },
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemCount: _cityResults.length,
    );
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Houses':
        return Icons.home;
      case 'Hostels':
        return Icons.apartment;
      case 'PGs':
        return Icons.meeting_room;
      case 'Commercial':
        return Icons.business;
      default:
        return Icons.home;
    }
  }
}



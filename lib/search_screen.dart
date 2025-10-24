import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as osm;
import 'package:latlong2/latlong.dart' as latlng;
import 'package:geolocator/geolocator.dart';
import 'search_filter.dart';
import 'filter_screen.dart';
import 'filter_status_bar.dart';
import 'house_data.dart';
import 'house_card.dart';
import 'city_service.dart';
import 'constants.dart';
import 'tile_layer_builder.dart';
import 'map_tile_toggle.dart';
import 'floating_controls.dart';

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

  // Map states
  bool _showMap = false;
  final latlng.LatLng _apCenter = apCenter; // Vijayawada
  final osm.MapController _mapController = osm.MapController();
  List<osm.Marker> _markers = [];
  final String _tileStyle = 'streets'; // streets | satellite | terrain | hybrid
  latlng.LatLng? _myLocation;
  latlng.LatLng? _searchLocation;
  Offset? _fabOffset;
  bool _mapIsReady = false;
  latlng.LatLng? _pendingMove;
  double? _pendingZoom;
  List<City> _cities = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadProperties();
    _loadCities();
    _searchController.addListener(_onSearchChanged);
  }

  void _loadProperties() {
    final houseData = HouseData.getHouseData();
    _allProperties = [];
    houseData.forEach((category, properties) {
      _allProperties.addAll(properties);
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

  Widget _buildList() {
    final transactionType = _appliedFilters?['transactionType'] ?? 'Rent';
    return _filteredProperties.isEmpty
        ? const Center(child: Text('No properties found'))
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
          );
  }

  Widget _buildMap() {
    return _isLoading
        ? Center(child: CircularProgressIndicator(color: Colors.amber[600]))
        : osm.FlutterMap(
            mapController: _mapController,
            options: osm.MapOptions(
              initialCenter: _apCenter,
              initialZoom: 7.5,
              minZoom: 5.5,
              maxZoom: 18,
              onMapReady: () {
                setState(() {
                  _mapIsReady = true;
                });
                if (_pendingMove != null) {
                  _mapController.move(_pendingMove!, _pendingZoom ?? 12);
                  _pendingMove = null;
                  _pendingZoom = null;
                }
              },
              interactionOptions: const osm.InteractionOptions(
                flags: osm.InteractiveFlag.all & ~osm.InteractiveFlag.rotate,
              ),
            ),
            children: [
              _buildTileLayer(),
              osm.MarkerLayer(markers: [
                if (_myLocation != null)
                  osm.Marker(
                    point: _myLocation!,
                    width: 36,
                    height: 36,
                    child: const Icon(Icons.location_on, color: Colors.red, size: 32),
                  ),
                if (_searchLocation != null)
                  osm.Marker(
                    point: _searchLocation!,
                    width: 32,
                    height: 32,
                    child: const Icon(Icons.place, color: Colors.amber, size: 28),
                  ),
                ..._markers,
              ]),
            ],
          );
  }

  void _clearFilters() {
    setState(() {
      _appliedFilters = null;
    });
    _applyFilters();
  }

  void _loadCities() async {
    setState(() {
      _isLoading = true;
    });
    try {
      final cities = CityService.getAndhraPradeshCities();
      setState(() {
        _cities = cities;
        _isLoading = false;
      });
      _buildMarkers();
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _buildMarkers() {
    final apMarkers = _cities.map((c) {
      return osm.Marker(
        point: latlng.LatLng(c.latitude, c.longitude),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _selectCity(c),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.15), blurRadius: 6, spreadRadius: 1),
              ],
              border: Border.all(color: Colors.amber.shade300),
            ),
            child: Icon(Icons.location_on, color: Colors.amber.shade700, size: 24),
          ),
        ),
      );
    }).toList();
    setState(() {
      _markers = apMarkers;
    });
  }

  void _selectCity(City city) {
    setState(() {
      _searchController.text = city.name;
      _showMap = false;
    });
    _applyFilters();
  }

  void _moveCamera(latlng.LatLng center, double zoom) {
    if (_mapIsReady) {
      _mapController.move(center, zoom);
    } else {
      _pendingMove = center;
      _pendingZoom = zoom;
    }
  }

  osm.TileLayer _buildTileLayer() => buildTileLayer(_tileStyle);

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
        automaticallyImplyLeading: false,
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () => setState(() => _showMap = false),
                style: ElevatedButton.styleFrom(
                  backgroundColor: !_showMap ? Colors.amber : Colors.grey,
                ),
                child: const Text('List'),
              ),
              const SizedBox(width: 16),
              ElevatedButton(
                onPressed: () => setState(() => _showMap = true),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _showMap ? Colors.amber : Colors.grey,
                ),
                child: const Text('Map'),
              ),
            ],
          ),
          Expanded(
            child: _showMap ? _buildMap() : _buildList(),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as osm;
import 'package:latlong2/latlong.dart' as latlng;
import 'package:url_launcher/url_launcher.dart';
import 'package:geolocator/geolocator.dart';
import 'city_service.dart';
import 'property_list_page.dart';
import 'tile_layer_builder.dart';
import 'constants.dart';

class MapScreen extends StatefulWidget {
  final City? selectedCity;
  final String? selectedCategory;
  
  const MapScreen({super.key, this.selectedCity, this.selectedCategory});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final latlng.LatLng _apCenter = apCenter; // Vijayawada
  // Andhra Pradesh bounding box (approx)
  static const double _apSouth = 12.5;
  static const double _apNorth = 19.5;
  static const double _apWest = 76.5;
  static const double _apEast = 85.0;

  final osm.MapController _mapController = osm.MapController();
  List<osm.Marker> _markers = [];
  String _tileStyle = 'streets'; // streets | satellite | terrain | hybrid
  latlng.LatLng? _myLocation;
  latlng.LatLng? _searchLocation;
  Offset? _fabOffset;
  bool _mapIsReady = false;
  latlng.LatLng? _pendingMove;
  double? _pendingZoom;

  List<City> _cities = [];
  List<City> _searchResults = [];
  bool _isLoading = true;
  // ignore: unused_field
  String _searchQuery = '';
  bool _showSearchResults = false;

  @override
  void initState() {
    super.initState();
    _loadCities();
    _getCurrentLocation();
    
    // Handle selected city or category
    if (widget.selectedCity != null) {
      _handleSelectedCity(widget.selectedCity!);
    } else if (widget.selectedCategory != null) {
      _handleSelectedCategory(widget.selectedCategory!);
    }
  }

  void _moveCamera(latlng.LatLng center, double zoom) {
    if (_mapIsReady) {
      _mapController.move(center, zoom);
    } else {
      _pendingMove = center;
      _pendingZoom = zoom;
    }
  }

  void _handleSelectedCity(City city) {
    final target = latlng.LatLng(city.latitude, city.longitude);
    setState(() {
      _searchLocation = target;
    });
    _moveCamera(target, 12);
    // Also open Houses list for the selected city
    Future.microtask(() {
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyListPage(
              cityName: city.name,
              category: 'Houses',
            ),
          ),
        );
      }
    });
  }

  void _handleSelectedCategory(String category) {
    // Show all properties of the selected category
    _showCategorySheet(null, category);
  }

  Future<void> _loadCities() async {
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
      _showError('Failed to load cities');
    }
  }

  void _buildMarkers() {
    final apMarkers = _cities.map((c) {
      return osm.Marker(
        point: latlng.LatLng(c.latitude, c.longitude),
        width: 40,
        height: 40,
        child: GestureDetector(
          onTap: () => _showCategorySheet(c),
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

  void _showCategorySheet(City? city, [String? category]) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.place, color: Colors.amber),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      city != null 
                          ? city.name
                          : 'Choose a location',
                      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text('What are you looking for?', style: TextStyle(fontWeight: FontWeight.w500)),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildCategoryTile(Icons.home, 'Houses', () {
                    Navigator.pop(context);
                    if (city != null) {
                      _openHouseDetails(city);
                    } else {
                      _openHouseDetails(null);
                    }
                  }),
                  _buildCategoryTile(Icons.apartment, 'Hostels', () {
                    Navigator.pop(context);
                    if (city != null) {
                      _openHostelsList(city);
                    } else {
                      _openHostelsList(null);
                    }
                  }),
                  _buildCategoryTile(Icons.meeting_room, 'PGs', () {
                    Navigator.pop(context);
                    if (city != null) {
                      _openPgsList(city);
                    } else {
                      _openPgsList(null);
                    }
                  }),
                ],
              ),
              const SizedBox(height: 12),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCategoryTile(IconData icon, String label, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 96,
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.amber[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.amber[200]!),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.amber[700]),
            const SizedBox(height: 6),
            Text(label, style: TextStyle(color: Colors.amber[800])),
          ],
        ),
      ),
    );
  }

  void _openHouseDetails(City? city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyListPage(
          cityName: city?.name ?? 'Andhra Pradesh',
          category: 'Houses',
        ),
      ),
    );
  }

  void _openHostelsList(City? city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyListPage(
          cityName: city?.name ?? 'Andhra Pradesh',
          category: 'Hostels',
        ),
      ),
    );
  }

  void _openPgsList(City? city) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyListPage(
          cityName: city?.name ?? 'Andhra Pradesh',
          category: 'PGs',
        ),
      ),
    );
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _loadDefaultLocation();
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        _loadDefaultLocation();
        return;
      }

      Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high,
      );

      final withinAp = _isWithinAp(position.latitude, position.longitude);
      final target = withinAp
          ? latlng.LatLng(position.latitude, position.longitude)
          : _apCenter;
      _moveCamera(target, withinAp ? 12 : 7.5);
      setState(() {
        _myLocation = target;
      });

      await _getAddressFromLocation(
        withinAp ? position.latitude : _apCenter.latitude,
        withinAp ? position.longitude : _apCenter.longitude,
      );
    } catch (e) {
      print('Error getting location: $e');
      _loadDefaultLocation();
    }
  }

  void _loadDefaultLocation() async {
    setState(() {
      _myLocation = _apCenter;
    });
    _moveCamera(_apCenter, 7.5);
  }

  Future<void> _getAddressFromLocation(double lat, double lng) async {
    try {
      await CityService.getAddressFromCoordinates(lat, lng);
      setState(() {
      });
    } catch (e) {
      setState(() {
      });
    }
  }

  void _searchCities(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults = [];
        _showSearchResults = false;
      });
      return;
    }

    final results = CityService.searchAndhraPradeshCities(query);
    setState(() {
      _searchResults = results;
      _showSearchResults = true;
    });
  }

  Future<void> _selectCity(City city) async {
    setState(() {
      _showSearchResults = false;
      _searchQuery = '';
    });

    _moveCamera(latlng.LatLng(city.latitude, city.longitude), 12);

    FocusScope.of(context).unfocus();
    // Open houses list for the selected city
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => PropertyListPage(
          cityName: city.name,
          category: 'Houses',
        ),
      ),
    );
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber[600],
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Search Map',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Search bar
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _searchCities,
                    onSubmitted: _onSearchSubmitted,
                    decoration: InputDecoration(
                      hintText: 'Search cities...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                IconButton(
                  onPressed: _getCurrentLocation,
                  icon: const Icon(Icons.my_location),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.amber,
                    foregroundColor: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          // Search results
          if (_showSearchResults && _searchResults.isNotEmpty)
            SizedBox(
              height: 200,
              child: ListView.builder(
                itemCount: _searchResults.length,
                itemBuilder: (context, index) {
                  final city = _searchResults[index];
                  return ListTile(
                    title: Text(city.name),
                    onTap: () => _selectCity(city),
                  );
                },
              ),
            ),
          // Removed location banner for cleaner UI
          // Map area
          Expanded(
            child: _isLoading
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(color: Colors.amber[600]),
                        const SizedBox(height: 16),
                        Text(
                          'Loading map...',
                          style: TextStyle(color: Colors.amber[700]),
                        ),
                      ],
                    ),
                  )
                : LayoutBuilder(builder: (context, constraints) {
                    _fabOffset ??= Offset(constraints.maxWidth - 72, constraints.maxHeight - 200);
                    return Stack(
                        children: [
                          osm.FlutterMap(
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
                                // My location (red) if available
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
                          ),
                          // Floating controls
                          Positioned(
                            right: 16,
                            bottom: 100,
                            child: Column(
                              children: [
                                FloatingActionButton.small(
                                  onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom + 1),
                                  child: const Icon(Icons.add),
                                ),
                                const SizedBox(height: 8),
                                FloatingActionButton.small(
                                  onPressed: () => _mapController.move(_mapController.camera.center, _mapController.camera.zoom - 1),
                                  child: const Icon(Icons.remove),
                                ),
                                const SizedBox(height: 8),
                                FloatingActionButton.small(
                                  onPressed: _openExternalMapsAtCenter,
                                  child: const Icon(Icons.directions),
                                ),
                              ],
                            ),
                          ),
                          // Map tile toggle
                          Positioned(
                            top: 16,
                            right: 16,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black26,
                                    blurRadius: 4,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: DropdownButton<String>(
                                value: _tileStyle,
                                underline: Container(),
                                items: const [
                                  DropdownMenuItem(value: 'streets', child: Text('Streets')),
                                  DropdownMenuItem(value: 'satellite', child: Text('Satellite')),
                                  DropdownMenuItem(value: 'terrain', child: Text('Terrain')),
                                ],
                                onChanged: (style) => setState(() => _tileStyle = style!),
                              ),
                            ),
                          ),
                        ],
                      );
                  }),
          ),
          // Map controls removed (replaced by My Location chip beside search bar)
        ],
      ),
    );
  }


  osm.TileLayer _buildTileLayer() => buildTileLayer(_tileStyle);


  void _showCitiesList() {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 500,
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.location_city, color: Colors.amber[700]),
                const SizedBox(width: 8),
                const Text(
                  'AP Cities',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${_cities.length} cities',
                  style: TextStyle(color: Colors.amber[700]),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: _cities.length,
                itemBuilder: (context, index) {
                  final city = _cities[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.amber[100],
                      child: Text(
                        city.countryCode,
                        style: TextStyle(
                          color: Colors.amber[700],
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                        ),
                      ),
                    ),
                    title: Text(city.name),
                    subtitle: Text(city.country),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16, color: Colors.amber[400]),
                    onTap: () {
                      Navigator.pop(context);
                      _selectCity(city);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showAbout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            Icon(Icons.info, color: Colors.green[600]),
            const SizedBox(width: 8),
            const Text('About Rentals Map'),
          ],
        ),
        content: const Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('🏠 Features:'),
            Text('• Search Andhra Pradesh cities'),
            Text('• Real GPS location detection'),
            Text('• OSM-based free map with themes'),
            Text('• Quick categories: Houses, Hostels, PGs'),
            Text('• Tap a category to see listings'),
            SizedBox(height: 16),
            Text('📍 This map shows major cities from all continents with their real coordinates and population data.'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  Future<void> _openExternalMapsToAp() async {
    // Opens external maps app to AP center for navigation demo (real nav requires a destination)
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${_apCenter.latitude},${_apCenter.longitude}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showError('Could not open Maps application');
    }
  }

  Future<void> _openExternalMapsAtCenter() async {
    final c = _mapController.camera.center;
    final uri = Uri.parse('https://www.google.com/maps/search/?api=1&query=${c.latitude},${c.longitude}');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showError('Could not open Maps application');
    }
  }

  Future<void> _onSearchSubmitted(String query) async {
    final trimmed = query.trim();
    if (trimmed.isEmpty) return;
    try {
      // If matches a known AP city, open houses list too
      final possible = CityService.searchAndhraPradeshCities(trimmed);
      final match = possible.firstWhere(
        (c) => c.name.toLowerCase() == trimmed.toLowerCase(),
        orElse: () => possible.isNotEmpty ? possible.first : City(name: '', country: '', countryCode: '', latitude: 0, longitude: 0, population: 0),
      );

      final coords = await CityService.getCoordinatesFromAddress(trimmed);
      if (coords == null) {
        _showError('Place not found');
        return;
      }
      final lat = coords['latitude']!;
      final lng = coords['longitude']!;
      final target = latlng.LatLng(lat, lng);
      setState(() {
        _searchLocation = target;
        _showSearchResults = false;
      });
      _moveCamera(target, 12);
      FocusScope.of(context).unfocus();

      if (match.name.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyListPage(
              cityName: match.name,
              category: 'Houses',
            ),
          ),
        );
      }
    } catch (_) {
      _showError('Search failed');
    }
  }

  // Helper method to check if coordinates are within Andhra Pradesh
  bool _isWithinAp(double lat, double lng) {
    return lat >= 12.5 && lat <= 19.5 && lng >= 76.5 && lng <= 85.0;
  }

  // Web or unsupported platform fallback map (keeps app working without Google Maps services)
  Widget _buildFallbackApMap(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.green[50],
        border: Border.all(color: Colors.green[200]!),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.green[100]!,
                  Colors.green[200]!,
                  Colors.green[300]!,
                  Colors.green[100]!,
                ],
              ),
            ),
          ),
          // AP cities projected approximately
          ..._cities.map((city) {
            final size = MediaQuery.of(context).size;
            final x = ((city.longitude - 76.5) / (85.0 - 76.5)) * size.width;
            final y = ((19.5 - city.latitude) / (19.5 - 12.5)) * size.height;
            return Positioned(
              left: x.clamp(8.0, size.width - 60),
              top: y.clamp(8.0, size.height - 60),
              child: GestureDetector(
                onTap: () => _selectCity(city),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.green.withOpacity(0.25),
                        blurRadius: 4,
                        spreadRadius: 1,
                      ),
                    ],
                    border: Border.all(color: Colors.green[300]!),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, color: Colors.green[700], size: 14),
                      const SizedBox(width: 4),
                      Text(
                        city.name,
                        style: TextStyle(fontSize: 10, color: Colors.green[800], fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        ],
      ),
    );
  }
}
 

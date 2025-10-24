// import 'dart:convert';
// import 'package:http/http.dart' as http;
import 'package:geocoding/geocoding.dart';

class Property {
  final String id;
  final String title;
  final double price;
  final double latitude;
  final double longitude;
  final String address;
  final String type;
  final int bedrooms;
  final int bathrooms;
  final double area;

  Property({
    required this.id,
    required this.title,
    required this.price,
    required this.latitude,
    required this.longitude,
    required this.address,
    required this.type,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
  });

  factory Property.fromJson(Map<String, dynamic> json) {
    return Property(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      price: (json['price'] ?? 0).toDouble(),
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      address: json['address'] ?? '',
      type: json['type'] ?? 'residential',
      bedrooms: json['bedrooms'] ?? 0,
      bathrooms: json['bathrooms'] ?? 0,
      area: (json['area'] ?? 0).toDouble(),
    );
  }
}

class PropertyService {
  // static const String _baseUrl = 'https://api.example.com'; // Replace with your API
  
  // Mock data for demonstration - replace with real API calls
  static Future<List<Property>> getPropertiesNearLocation({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
  }) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock properties around the given location
    return [
      Property(
        id: '1',
        title: 'Modern Apartment Downtown',
        price: 2500,
        latitude: latitude + 0.01,
        longitude: longitude + 0.01,
        address: '123 Main St, Downtown',
        type: 'apartment',
        bedrooms: 2,
        bathrooms: 2,
        area: 1200,
      ),
      Property(
        id: '2',
        title: 'Family House with Garden',
        price: 450000,
        latitude: latitude - 0.02,
        longitude: longitude + 0.015,
        address: '456 Oak Ave, Suburbs',
        type: 'house',
        bedrooms: 4,
        bathrooms: 3,
        area: 2500,
      ),
      Property(
        id: '3',
        title: 'Luxury Penthouse',
        price: 1200000,
        latitude: latitude + 0.005,
        longitude: longitude - 0.01,
        address: '789 Sky Tower, City Center',
        type: 'penthouse',
        bedrooms: 3,
        bathrooms: 3,
        area: 3000,
      ),
      Property(
        id: '4',
        title: 'Cozy Studio Apartment',
        price: 1800,
        latitude: latitude - 0.015,
        longitude: longitude - 0.02,
        address: '321 Student St, University Area',
        type: 'studio',
        bedrooms: 1,
        bathrooms: 1,
        area: 600,
      ),
    ];
  }

  static Future<List<Property>> searchProperties(String query) async {
    // Simulate API delay
    await Future.delayed(const Duration(seconds: 1));
    
    // Mock search results
    return [
      Property(
        id: '5',
        title: 'Search Result Property',
        price: 320000,
        latitude: 40.7128,
        longitude: -74.0060,
        address: 'Search Result Address',
        type: 'house',
        bedrooms: 3,
        bathrooms: 2,
        area: 1800,
      ),
    ];
  }

  static Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.street}, ${place.locality}, ${place.administrativeArea}';
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return 'Unknown Location';
  }

  static Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        return {
          'latitude': location.latitude,
          'longitude': location.longitude,
        };
      }
    } catch (e) {
      print('Error getting coordinates: $e');
    }
    return null;
  }
}

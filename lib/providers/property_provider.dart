import 'package:flutter/foundation.dart';
import 'package:homeus/house_data.dart';

class PropertyProvider extends ChangeNotifier {
  final List<Map<String, dynamic>> _allProperties = [];
  List<Map<String, dynamic>> _filteredProperties = [];
  final List<Map<String, dynamic>> _favoriteProperties = [];
  final List<Map<String, dynamic>> _recentlyViewedProperties = [];
  bool _isLoading = false;
  String? _error;
  
  // Getters
  List<Map<String, dynamic>> get allProperties => _allProperties;
  List<Map<String, dynamic>> get filteredProperties => _filteredProperties;
  List<Map<String, dynamic>> get favoriteProperties => _favoriteProperties;
  List<Map<String, dynamic>> get recentlyViewedProperties => _recentlyViewedProperties;
  bool get isLoading => _isLoading;
  String? get error => _error;
  
  // Property management
  void loadProperties() {
    _setLoading(true);
    try {
      final houseData = HouseData.getHouseData();
      _allProperties.clear();
      
      houseData.forEach((category, properties) {
        for (var property in properties) {
          _allProperties.add({
            ...property,
            'category': category,
            'id': property['id'] ?? '${category}_${_allProperties.length}',
          });
        }
      });
      
      _filteredProperties = List.from(_allProperties);
      _setError(null);
    } catch (e) {
      _setError('Failed to load properties: $e');
    } finally {
      _setLoading(false);
    }
  }
  
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }
  
  // Filtering and searching
  void applyFilters({
    String? searchQuery,
    Map<String, dynamic>? filters,
  }) {
    _filteredProperties = _allProperties.where((property) {
      // Search filter
      if (searchQuery != null && searchQuery.isNotEmpty) {
        final query = searchQuery.toLowerCase();
        final matchesSearch = 
            property['title']?.toString().toLowerCase().contains(query) == true ||
            property['location']?.toString().toLowerCase().contains(query) == true ||
            property['category']?.toString().toLowerCase().contains(query) == true;
        
        if (!matchesSearch) return false;
      }
      
      // Additional filters
      if (filters != null) {
        // Transaction type filter
        final transactionType = filters['transactionType'] ?? 'Rent';
        
        // Category filter
        if (filters['categoryType'] != null && 
            property['category'] != filters['categoryType']) {
          return false;
        }
        
        // Property type filter
        if (filters['selectedPropertyType'] != null && 
            property['propertyType'] != filters['selectedPropertyType']) {
          return false;
        }
        
        // Price range filter
        final minPrice = filters['minPrice'] ?? 0;
        final maxPrice = filters['maxPrice'] ?? double.infinity;
        final priceKey = transactionType == 'Rent' ? 'rentPrice' : 'buyPrice';
        final price = property[priceKey] ?? 0;
        
        if (price < minPrice || price > maxPrice) {
          return false;
        }
        
        // Amenities filter
        if (filters['amenities'] != null) {
          final requiredAmenities = filters['amenities'] as List<String>;
          final propertyAmenities = property['amenities'] as List<String>? ?? [];
          
          for (String amenity in requiredAmenities) {
            if (!propertyAmenities.contains(amenity)) {
              return false;
            }
          }
        }
      }
      
      return true;
    }).toList();
    
    notifyListeners();
  }
  
  void clearFilters() {
    _filteredProperties = List.from(_allProperties);
    notifyListeners();
  }
  
  // Property interactions
  void addToFavorites(Map<String, dynamic> property) {
    final propertyId = property['id'] ?? property['title'];
    if (!_favoriteProperties.any((p) => p['id'] == propertyId)) {
      _favoriteProperties.add(property);
      notifyListeners();
    }
  }
  
  void removeFromFavorites(String propertyId) {
    _favoriteProperties.removeWhere((p) => p['id'] == propertyId);
    notifyListeners();
  }
  
  bool isFavorite(String propertyId) {
    return _favoriteProperties.any((p) => p['id'] == propertyId);
  }
  
  void addToRecentlyViewed(Map<String, dynamic> property) {
    final propertyId = property['id'] ?? property['title'];
    
    // Remove if already exists
    _recentlyViewedProperties.removeWhere((p) => p['id'] == propertyId);
    
    // Add to beginning
    _recentlyViewedProperties.insert(0, {
      ...property,
      'viewedAt': DateTime.now(),
    });
    
    // Keep only last 20 viewed properties
    if (_recentlyViewedProperties.length > 20) {
      _recentlyViewedProperties.removeLast();
    }
    
    notifyListeners();
  }
  
  void clearRecentlyViewed() {
    _recentlyViewedProperties.clear();
    notifyListeners();
  }
  
  // Property retrieval
  Map<String, dynamic>? getPropertyById(String propertyId) {
    try {
      return _allProperties.firstWhere((p) => p['id'] == propertyId);
    } catch (e) {
      return null;
    }
  }
  
  List<Map<String, dynamic>> getPropertiesByCategory(String category) {
    return _allProperties.where((p) => p['category'] == category).toList();
  }
  
  List<Map<String, dynamic>> getPropertiesByLocation(String location) {
    return _allProperties.where((p) => 
      p['location']?.toString().toLowerCase().contains(location.toLowerCase()) == true
    ).toList();
  }
  
  // Statistics
  int get totalProperties => _allProperties.length;
  int get filteredCount => _filteredProperties.length;
  int get favoritesCount => _favoriteProperties.length;
  
  Map<String, int> get propertiesByCategory {
    final Map<String, int> counts = {};
    for (var property in _allProperties) {
      final category = property['category'] ?? 'Unknown';
      counts[category] = (counts[category] ?? 0) + 1;
    }
    return counts;
  }
}
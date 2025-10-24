import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AppStateProvider extends ChangeNotifier {
  // User state
  User? _currentUser;
  bool _isLoading = false;
  String? _error;
  
  // App preferences
  String _selectedLanguage = 'English';
  bool _notificationsEnabled = true;
  bool _locationEnabled = false;
  
  // Search and filter state
  Map<String, dynamic>? _activeFilters;
  String _lastSearchQuery = '';
  final List<Map<String, dynamic>> _searchHistory = [];
  
  // Wishlist state
  final List<String> _wishlistItems = [];
  
  // Getters
  User? get currentUser => _currentUser;
  bool get isLoading => _isLoading;
  String? get error => _error;
  String get selectedLanguage => _selectedLanguage;
  bool get notificationsEnabled => _notificationsEnabled;
  bool get locationEnabled => _locationEnabled;
  Map<String, dynamic>? get activeFilters => _activeFilters;
  String get lastSearchQuery => _lastSearchQuery;
  List<Map<String, dynamic>> get searchHistory => _searchHistory;
  List<String> get wishlistItems => _wishlistItems;
  
  bool get isAuthenticated => _currentUser != null;
  String get userDisplayName => _currentUser?.displayName ?? 'User';
  String get userEmail => _currentUser?.email ?? '';
  
  // User management
  void setCurrentUser(User? user) {
    _currentUser = user;
    notifyListeners();
  }
  
  void setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }
  
  void setError(String? error) {
    _error = error;
    notifyListeners();
  }
  
  void clearError() {
    _error = null;
    notifyListeners();
  }
  
  // App preferences
  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    notifyListeners();
  }
  
  void setNotificationsEnabled(bool enabled) {
    _notificationsEnabled = enabled;
    notifyListeners();
  }
  
  void setLocationEnabled(bool enabled) {
    _locationEnabled = enabled;
    notifyListeners();
  }
  
  // Search and filters
  void setActiveFilters(Map<String, dynamic>? filters) {
    _activeFilters = filters;
    notifyListeners();
  }
  
  void clearFilters() {
    _activeFilters = null;
    notifyListeners();
  }
  
  void setLastSearchQuery(String query) {
    _lastSearchQuery = query;
    if (query.trim().isNotEmpty && !_searchHistory.any((item) => item['query'] == query)) {
      _searchHistory.insert(0, {
        'query': query,
        'timestamp': DateTime.now(),
      });
      // Keep only last 10 searches
      if (_searchHistory.length > 10) {
        _searchHistory.removeLast();
      }
    }
    notifyListeners();
  }
  
  void clearSearchHistory() {
    _searchHistory.clear();
    notifyListeners();
  }
  
  // Wishlist management
  void addToWishlist(String propertyId) {
    if (!_wishlistItems.contains(propertyId)) {
      _wishlistItems.add(propertyId);
      notifyListeners();
    }
  }
  
  void removeFromWishlist(String propertyId) {
    _wishlistItems.remove(propertyId);
    notifyListeners();
  }
  
  bool isInWishlist(String propertyId) {
    return _wishlistItems.contains(propertyId);
  }
  
  void clearWishlist() {
    _wishlistItems.clear();
    notifyListeners();
  }
  
  // Reset all state (useful for logout)
  void resetState() {
    _currentUser = null;
    _isLoading = false;
    _error = null;
    _activeFilters = null;
    _lastSearchQuery = '';
    _searchHistory.clear();
    _wishlistItems.clear();
    notifyListeners();
  }
}
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class PreferencesService {
  static SharedPreferences? _prefs;
  
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }
  
  // String operations
  static Future<bool> setString(String key, String value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setString(key, value);
  }
  
  static String? getString(String key) {
    return _prefs?.getString(key);
  }
  
  // Boolean operations
  static Future<bool> setBool(String key, bool value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setBool(key, value);
  }
  
  static bool getBool(String key, {bool defaultValue = false}) {
    return _prefs?.getBool(key) ?? defaultValue;
  }
  
  // Integer operations
  static Future<bool> setInt(String key, int value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setInt(key, value);
  }
  
  static int getInt(String key, {int defaultValue = 0}) {
    return _prefs?.getInt(key) ?? defaultValue;
  }
  
  // Double operations
  static Future<bool> setDouble(String key, double value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setDouble(key, value);
  }
  
  static double getDouble(String key, {double defaultValue = 0.0}) {
    return _prefs?.getDouble(key) ?? defaultValue;
  }
  
  // List operations
  static Future<bool> setStringList(String key, List<String> value) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.setStringList(key, value);
  }
  
  static List<String> getStringList(String key) {
    return _prefs?.getStringList(key) ?? [];
  }
  
  // JSON operations
  static Future<bool> setJson(String key, Map<String, dynamic> value) async {
    _prefs ??= await SharedPreferences.getInstance();
    final jsonString = json.encode(value);
    return await _prefs!.setString(key, jsonString);
  }
  
  static Map<String, dynamic>? getJson(String key) {
    final jsonString = _prefs?.getString(key);
    if (jsonString != null) {
      try {
        return json.decode(jsonString) as Map<String, dynamic>;
      } catch (e) {
        return null;
      }
    }
    return null;
  }
  
  // List of JSON operations
  static Future<bool> setJsonList(String key, List<Map<String, dynamic>> value) async {
    _prefs ??= await SharedPreferences.getInstance();
    final jsonString = json.encode(value);
    return await _prefs!.setString(key, jsonString);
  }
  
  static List<Map<String, dynamic>> getJsonList(String key) {
    final jsonString = _prefs?.getString(key);
    if (jsonString != null) {
      try {
        final List<dynamic> decoded = json.decode(jsonString) as List<dynamic>;
        return decoded.cast<Map<String, dynamic>>();
      } catch (e) {
        return [];
      }
    }
    return [];
  }
  
  // Remove operations
  static Future<bool> remove(String key) async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.remove(key);
  }
  
  static Future<bool> clear() async {
    _prefs ??= await SharedPreferences.getInstance();
    return await _prefs!.clear();
  }
  
  // Check if key exists
  static bool containsKey(String key) {
    return _prefs?.containsKey(key) ?? false;
  }
  
  // App-specific preference keys
  static const String keyHasSeenOnboarding = 'hasSeenOnboarding';
  static const String keySelectedLanguage = 'selectedLanguage';
  static const String keyNotificationsEnabled = 'notificationsEnabled';
  static const String keyLocationEnabled = 'locationEnabled';
  static const String keySearchHistory = 'searchHistory';
  static const String keyFavoriteProperties = 'favoriteProperties';
  static const String keyRecentlyViewedProperties = 'recentlyViewedProperties';
  static const String keyUserPreferences = 'userPreferences';
  static const String keyLastSearchFilters = 'lastSearchFilters';
  static const String keyThemeMode = 'themeMode';
  
  // App-specific convenience methods
  static Future<bool> setHasSeenOnboarding(bool value) => 
      setBool(keyHasSeenOnboarding, value);
  
  static bool getHasSeenOnboarding() => 
      getBool(keyHasSeenOnboarding);
  
  static Future<bool> setSelectedLanguage(String language) => 
      setString(keySelectedLanguage, language);
  
  static String getSelectedLanguage() => 
      getString(keySelectedLanguage) ?? 'English';
  
  static Future<bool> setNotificationsEnabled(bool enabled) => 
      setBool(keyNotificationsEnabled, enabled);
  
  static bool getNotificationsEnabled() => 
      getBool(keyNotificationsEnabled, defaultValue: true);
  
  static Future<bool> setLocationEnabled(bool enabled) => 
      setBool(keyLocationEnabled, enabled);
  
  static bool getLocationEnabled() => 
      getBool(keyLocationEnabled);
  
  static Future<bool> setSearchHistory(List<String> history) => 
      setStringList(keySearchHistory, history);
  
  static List<String> getSearchHistory() => 
      getStringList(keySearchHistory);
  
  static Future<bool> setFavoriteProperties(List<Map<String, dynamic>> favorites) => 
      setJsonList(keyFavoriteProperties, favorites);
  
  static List<Map<String, dynamic>> getFavoriteProperties() => 
      getJsonList(keyFavoriteProperties);
  
  static Future<bool> setRecentlyViewedProperties(List<Map<String, dynamic>> properties) => 
      setJsonList(keyRecentlyViewedProperties, properties);
  
  static List<Map<String, dynamic>> getRecentlyViewedProperties() => 
      getJsonList(keyRecentlyViewedProperties);
  
  static Future<bool> setUserPreferences(Map<String, dynamic> preferences) => 
      setJson(keyUserPreferences, preferences);
  
  static Map<String, dynamic>? getUserPreferences() => 
      getJson(keyUserPreferences);
  
  static Future<bool> setLastSearchFilters(Map<String, dynamic> filters) => 
      setJson(keyLastSearchFilters, filters);
  
  static Map<String, dynamic>? getLastSearchFilters() => 
      getJson(keyLastSearchFilters);
  
  static Future<bool> setThemeMode(String themeMode) => 
      setString(keyThemeMode, themeMode);
  
  static String getThemeMode() => 
      getString(keyThemeMode) ?? 'system';
}
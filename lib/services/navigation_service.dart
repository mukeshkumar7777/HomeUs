import 'package:flutter/material.dart';
import 'package:homeus/app_routes.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static BuildContext? get context => navigatorKey.currentContext;
  
  static Future<T?> navigateTo<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamed<T>(routeName, arguments: arguments);
  }
  
  static Future<T?> navigateAndReplace<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushReplacementNamed(routeName, arguments: arguments);
  }
  
  static Future<T?> navigateAndClearStack<T>(String routeName, {Object? arguments}) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(
      routeName, 
      (route) => false,
      arguments: arguments,
    );
  }
  
  static void goBack<T>([T? result]) {
    return navigatorKey.currentState!.pop<T>(result);
  }
  
  static bool canGoBack() {
    return navigatorKey.currentState!.canPop();
  }
  
  // Convenience methods for common navigation patterns
  static Future<void> goToPropertyDetails({
    required String imageAsset,
    required String title,
    required String location,
    required String price,
    String? description,
    List<String>? amenities,
    String? contactInfo,
    dynamic property,
  }) {
    return navigateTo(AppRoutes.propertyDetails, arguments: {
      'imageAsset': imageAsset,
      'title': title,
      'location': location,
      'price': price,
      'description': description,
      'amenities': amenities,
      'contactInfo': contactInfo,
      'property': property,
    });
  }
  
  static Future<void> goToEditProfile({
    required String currentName,
    required String currentEmail,
    required Function(String, String) onProfileUpdated,
  }) {
    return navigateTo(AppRoutes.editProfile, arguments: {
      'currentName': currentName,
      'currentEmail': currentEmail,
      'onProfileUpdated': onProfileUpdated,
    });
  }
  
  static Future<void> goToTermsConditions({String language = 'English'}) {
    return navigateTo(AppRoutes.termsConditions, arguments: {
      'language': language,
    });
  }
  
  static Future<void> goToPayment({
    String language = 'English',
    required String userName,
    required String userEmail,
  }) {
    return navigateTo(AppRoutes.payment, arguments: {
      'language': language,
      'userName': userName,
      'userEmail': userEmail,
    });
  }
  
  // Quick navigation methods
  static Future<void> goToSearch() => navigateTo(AppRoutes.search);
  static Future<void> goToSettings() => navigateTo(AppRoutes.settings);
  static Future<void> goToWishlist() => navigateTo(AppRoutes.wishlist);
  static Future<void> goToHelp() => navigateTo(AppRoutes.help);
  static Future<void> goToAbout() => navigateTo(AppRoutes.about);
  static Future<void> goToNotifications() => navigateTo(AppRoutes.notifications);
  static Future<void> goToFilter() => navigateTo(AppRoutes.filter);
  
  // Auth navigation
  static Future<void> goToLogin() => navigateAndReplace(AppRoutes.login);
  static Future<void> goToHome() => navigateAndClearStack(AppRoutes.home);
}
import 'package:flutter/material.dart';
import 'package:homeus/auth_wrapper.dart';
import 'package:homeus/main_navigation.dart';
import 'package:homeus/login_signup/login_page.dart';
import 'package:homeus/splash_onboarding.dart';
import 'package:homeus/search_screen.dart';
import 'package:homeus/property_details.dart';
import 'package:homeus/edit_profile_screen.dart';
import 'package:homeus/settings_screen.dart';
import 'package:homeus/wishlist_screen.dart';
import 'package:homeus/filter_screen.dart';
import 'package:homeus/help_screen.dart';
import 'package:homeus/about_screen.dart';
import 'package:homeus/notification_page.dart';
import 'package:homeus/terms_conditions_screen.dart';
import 'package:homeus/payment_screen.dart';

class AppRoutes {
  static const String auth = '/auth';
  static const String home = '/home';
  static const String login = '/login';
  static const String splash = '/splash';
  static const String search = '/search';
  static const String propertyDetails = '/property-details';
  static const String editProfile = '/edit-profile';
  static const String settings = '/settings';
  static const String wishlist = '/wishlist';
  static const String filter = '/filter';
  static const String help = '/help';
  static const String about = '/about';
  static const String notifications = '/notifications';
  static const String termsConditions = '/terms-conditions';
  static const String payment = '/payment';

  static Map<String, WidgetBuilder> getRoutes() {
    return {
      auth: (context) => const AuthWrapper(),
      home: (context) => const MainNavigation(),
      login: (context) => const Signin(),
      splash: (context) => const SplashScreen(),
      search: (context) => const SearchScreen(),
      settings: (context) => const SettingsScreen(),
      wishlist: (context) => const WishlistScreen(),
      filter: (context) => const FilterScreen(),
      help: (context) => const HelpScreen(),
      about: (context) => const AboutScreen(),
      notifications: (context) => const NotificationPage(),
    };
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case propertyDetails:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => PropertyDetailsScreen(
            imageAsset: args?['imageAsset'] ?? '',
            title: args?['title'] ?? '',
            location: args?['location'] ?? '',
            price: args?['price'] ?? '',
            description: args?['description'],
            amenities: args?['amenities'],
            contactInfo: args?['contactInfo'],
            property: args?['property'],
          ),
        );
      case editProfile:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            currentName: args?['currentName'] ?? '',
            currentEmail: args?['currentEmail'] ?? '',
            onProfileUpdated: args?['onProfileUpdated'] ?? (String name, String email) {},
          ),
        );
      case termsConditions:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => TermsConditionsScreen(
            language: args?['language'] ?? 'English',
          ),
        );
      case payment:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (context) => PaymentScreen(
            language: args?['language'] ?? 'English',
            userName: args?['userName'] ?? '',
            userEmail: args?['userEmail'] ?? '',
          ),
        );
      default:
        return null;
    }
  }
}
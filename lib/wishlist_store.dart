import 'package:flutter/material.dart';
import 'property_model.dart';

class WishlistStore extends ChangeNotifier {
  static final WishlistStore _instance = WishlistStore._internal();
  factory WishlistStore() => _instance;
  WishlistStore._internal();

  final List<Property> _items = [];
  List<Property> get items => List.unmodifiable(_items);

  bool contains(Property p) => _items.any((e) => e.title == p.title && e.location == p.location);

  void add(Property p) {
    if (!contains(p)) {
      _items.add(p);
      notifyListeners();
    }
  }

  void remove(Property p) {
    _items.removeWhere((e) => e.title == p.title && e.location == p.location);
    notifyListeners();
  }
}



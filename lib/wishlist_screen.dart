import 'package:flutter/material.dart';
import 'wishlist_store.dart';
import 'propertycard.dart';
import 'property_model.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final store = WishlistStore();
    return Scaffold(
      appBar: AppBar(title: const Text('Wishlist')),
      body: AnimatedBuilder(
        animation: store,
        builder: (_, __) {
          if (store.items.isEmpty) {
            return const Center(
              child: Text(
                'Your saved homes will appear here',
                style: TextStyle(color: Colors.black54),
              ),
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: store.items.length,
            itemBuilder: (context, index) {
              final Property p = store.items[index];
              return PropertyCard(
                property: p,
                imageAsset: p.imageAsset,
                title: p.title,
                location: p.location,
                price: p.price,
              );
            },
          );
        },
      ),
    );
  }
}



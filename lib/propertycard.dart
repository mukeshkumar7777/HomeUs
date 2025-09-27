
import 'package:flutter/material.dart';
import 'property_details.dart';
import 'property_model.dart';
import 'responsive.dart';
// Removed unused import

class PropertyCard extends StatelessWidget {
  final Property? property;
  final String imageAsset, title, location, price;

  const PropertyCard({
    super.key,
    this.property,
    required this.imageAsset,
    required this.title,
    required this.location,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    final double imageHeight = Responsive.value<double>(
      context: context,
      mobile: 180,
      tablet: 240,
      desktop: 300,
    );

    final EdgeInsetsGeometry cardPadding = Responsive.value<EdgeInsetsGeometry>(
      context: context,
      mobile: const EdgeInsets.all(12),
      tablet: const EdgeInsets.all(16),
      desktop: const EdgeInsets.all(20),
    );

    final double titleFont = Responsive.value<double>(
      context: context,
      mobile: 16,
      tablet: 18,
      desktop: 20,
    );

    final double priceFont = Responsive.value<double>(
      context: context,
      mobile: 15,
      tablet: 16,
      desktop: 18,
    );

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 4,
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PropertyDetailsScreen(
                property: property,
                imageAsset: imageAsset,
                title: title,
                location: location,
                price: price,
              ),
            ),
          );
        },
        child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                child: Image.asset(imageAsset, height: imageHeight, width: double.infinity, fit: BoxFit.cover),
              ),
            ],
          ),
          Padding(
            padding: cardPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: titleFont,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(location, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 6),
                Text(
                  price,
                  style: TextStyle(
                    fontSize: priceFont,
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 10),
                Align(
                  alignment: Alignment.centerRight,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PropertyDetailsScreen(
                            property: property,
                            imageAsset: imageAsset,
                            title: title,
                            location: location,
                            price: price,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text("View Details"),
                  ),
                )
              ],
            ),
          ),
        ],
        ),
      ),
    );
  }
}

// _WishlistButton class removed

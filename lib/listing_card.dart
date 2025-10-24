import 'package:flutter/material.dart';
import 'property_detail_page.dart';

class ListingCard extends StatelessWidget {
  final String title;
  final String price;
  final String subtitle;
  final List<String> tags;
  final String assetImage; // e.g. lib/assets/house1.jpg
  const ListingCard({super.key, required this.title, required this.price, required this.subtitle, required this.tags, required this.assetImage});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, spreadRadius: 1)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => PropertyDetailPage(
                    title: title,
                    pricePerMonth: price,
                    locationLine: subtitle,
                    assetImage: assetImage,
                    bedrooms: 2,
                    bathrooms: 2,
                    area: '1,200 sq ft',
                    type: 'Apartment',
                  ),
                ),
              );
            },
            child: ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
            child: AspectRatio(
              aspectRatio: 16/9,
              child: Image.asset(assetImage, fit: BoxFit.cover),
            ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
                    ),
                    Text(price, style: TextStyle(color: Colors.amber[700], fontWeight: FontWeight.w800)),
                  ],
                ),
                const SizedBox(height: 8),
                Text(subtitle, style: TextStyle(color: Colors.grey[700])),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: tags.map((t) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey[300]!),
                    ),
                    child: Text(t, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
                  )).toList(),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyDetailPage(
                                title: title,
                                pricePerMonth: price,
                                locationLine: subtitle,
                                assetImage: assetImage,
                                bedrooms: 2,
                                bathrooms: 2,
                                area: '1,200 sq ft',
                                type: 'Apartment',
                              ),
                            ),
                          );
                        },
                        child: const Text('View Details'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => PropertyDetailPage(
                                title: title,
                                pricePerMonth: price,
                                locationLine: subtitle,
                                assetImage: assetImage,
                                bedrooms: 2,
                                bathrooms: 2,
                                area: '1,200 sq ft',
                                type: 'Apartment',
                              ),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[600], foregroundColor: Colors.black),
                        child: const Text('Contact'),
                      ),
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}



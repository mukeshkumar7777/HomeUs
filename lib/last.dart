// lib/widgets/last_viewed_homes.dart
import 'package:flutter/material.dart';

class LastViewedHomes extends StatelessWidget {
  const LastViewedHomes({super.key});

  @override
  Widget build(BuildContext context) {
    final homes = [
      {
        "image":"https://images.unsplash.com/photo-1570129477492-45c003edd2be",
        "title": "Modern Villa",
        "price": "\$250,000",
        "location": "Miami Beach"
      },
      {
        "image": "https://images.unsplash.com/photo-1570129477492-45c003edd2be",
        "title": "Countryside House",
        "price": "\$180,000",
        "location": "Texas"
      },
      {
        "image": "https://images.unsplash.com/photo-1570129477492-45c003edd2be",
        "title": "City Apartment",
        "price": "\$300,000",
        "location": "New York"
      },
      {
        "image": "https://images.unsplash.com/photo-1570129477492-45c003edd2be",
        "title": "Luxury Mansion",
        "price": "\$1,200,000",
        "location": "Los Angeles"
      },
    ];

    final screenWidth = MediaQuery.of(context).size.width;

    return ListView.separated(
      shrinkWrap: true, // allows embedding inside SingleChildScrollView
      physics: const NeverScrollableScrollPhysics(), // parent scroll handles
      itemCount: homes.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final home = homes[index];
        return Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                blurRadius: 6,
                offset: const Offset(0, 3),
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(12)),
                child: Image.network(
                  home['image']!,
                  height: screenWidth < 400 ? 160 : 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      home['title']!,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      home['price']!,
                      style: const TextStyle(
                          fontSize: 16, color: Colors.green),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            size: 16, color: Colors.grey),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            home['location']!,
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
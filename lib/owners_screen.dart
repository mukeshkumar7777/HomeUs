import 'package:flutter/material.dart';
import 'property_details.dart';

class OwnersScreen extends StatelessWidget {
  const OwnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample owned properties
    final List<Map<String, dynamic>> ownedProperties = [
      {
        'images': ['assets/house 1.jpg', 'assets/house2.jpg'],
        'title': 'My Cozy Apartment',
        'location': 'Hyderabad',
        'price': 15000.0,
        'status': 'Rented',
      },
      {
        'images': ['assets/house3.jpg'],
        'title': 'Modern Flat',
        'location': 'Kakinada',
        'price': 20000.0,
        'status': 'Available',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Owners Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {
              // TODO: Add new property
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Properties',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: ListView.builder(
                itemCount: ownedProperties.length,
                itemBuilder: (context, index) {
                  final property = ownedProperties[index];
                  final images = List<String>.from(property['images'] ?? []);
                  final title = property['title'] ?? 'No Title';
                  final location = property['location'] ?? '';
                  final price = property['price'] ?? 0.0;
                  final status = property['status'] ?? 'Unknown';

                  return Card(
                    margin: const EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (images.isNotEmpty)
                            SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                itemBuilder: (context, imgIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8),
                                      child: Image.asset(
                                        images[imgIndex],
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) {
                                          return const Icon(Icons.broken_image, size: 100);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(fontWeight: FontWeight.w600),
                                    ),
                                    Text(location),
                                    Text(
                                      '₹${price.toStringAsFixed(0)}/Month',
                                      style: const TextStyle(color: Colors.green),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                decoration: BoxDecoration(
                                  color: status == 'Rented' ? Colors.green : Colors.orange,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  status,
                                  style: const TextStyle(color: Colors.white, fontSize: 12),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PropertyDetailsScreen(
                                        imageAsset: images.isNotEmpty ? images[0] : 'assets/house 1.jpg',
                                        title: title,
                                        location: location,
                                        price: '₹${price.toStringAsFixed(0)}/Month',
                                        description: 'Property details here.',
                                      ),
                                    ),
                                  );
                                },
                                child: const Text('View Details'),
                              ),
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  // TODO: Edit property
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

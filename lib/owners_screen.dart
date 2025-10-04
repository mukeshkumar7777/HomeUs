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
      {
        'images': ['assets/house4.jpg'],
        'title': 'Spacious Villa',
        'location': 'Vizag',
        'price': 25000.0,
        'status': 'Available',
      },
      {
        'images': ['assets/house5.jpg'],
        'title': 'Luxury Apartment',
        'location': 'Rajamundry',
        'price': 30000.0,
        'status': 'Rented',
      },
      {
        'images': ['assets/house6.jpg'],
        'title': 'Comfortable Home',
        'location': 'Hyderabad',
        'price': 18000.0,
        'status': 'Available',
      },
      {
        'images': ['assets/house7.jpg'],
        'title': 'Elegant Residence',
        'location': 'Kakinada',
        'price': 22000.0,
        'status': 'Rented',
      },
      {
        'images': ['assets/pg2.jpg'],
        'title': 'Paying Guest Room',
        'location': 'Vizag',
        'price': 8000.0,
        'status': 'Available',
      },
      {
        'images': ['assets/pgs.jpg'],
        'title': 'Shared Accommodation',
        'location': 'Rajamundry',
        'price': 10000.0,
        'status': 'Rented',
      },
      {
        'images': ['assets/2bhk.jpg'],
        'title': '2BHK Flat',
        'location': 'Hyderabad',
        'price': 25000.0,
        'status': 'Available',
      },
      {
        'images': ['assets/hostel1.jpg'],
        'title': 'Student Hostel',
        'location': 'Kakinada',
        'price': 5000.0,
        'status': 'Rented',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Owners Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black87,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.amber[300],
        elevation: 2,
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add New Property',
            onPressed: () {
              // TODO: Add new property functionality
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
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 6,
                    shadowColor: Colors.amber.shade200,
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (images.isNotEmpty)
                            SizedBox(
                              height: 120,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images.length,
                                itemBuilder: (context, imgIndex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 12),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.asset(
                                        images[imgIndex],
                                        width: 120,
                                        height: 120,
                                        fit: BoxFit.cover,
                                        errorBuilder: (context, error, stack) {
                                          return const Icon(Icons.broken_image, size: 120);
                                        },
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      title,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 18,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      location,
                                      style: const TextStyle(
                                        color: Colors.grey,
                                        fontSize: 14,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '₹${price.toStringAsFixed(0)}/Month',
                                      style: const TextStyle(
                                        color: Colors.green,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 16,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                decoration: BoxDecoration(
                                  color: status == 'Rented' ? Colors.green : Colors.orange,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: Text(
                                  status,
                                  style: const TextStyle(color: Colors.white, fontSize: 14),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
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
                                tooltip: 'Edit Property',
                                onPressed: () {
                                  // TODO: Edit property functionality
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                tooltip: 'Delete Property',
                                onPressed: () {
                                  // TODO: Delete property functionality
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.share),
                                tooltip: 'Share Property',
                                onPressed: () {
                                  // TODO: Share property functionality
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

import 'package:flutter/material.dart';
import 'property_details.dart';

class OwnersScreen extends StatelessWidget {
  const OwnersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;

    final List<Map<String, dynamic>> ownedProperties = [
      {
        'images': [ 'assets/house2.jpg'],
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
        'images': ['assets/house5.jpg'],
        'title': 'Luxury Apartment',
        'location': 'Rajamundry',
        'price': 30000.0,
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
        'images': ['assets/house3.jpg'],
        'title': 'Spacious Villa',
        'location': 'Vizag',
        'price': 25000.0,
        'status': 'Available',
      },
    ];

    return Scaffold(
      backgroundColor: isDark ? Colors.black : const Color(0xFFF8F8F8),
      appBar: AppBar(
        title: const Text(
          'Owner Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 22,
          ),
        ),
        centerTitle: true,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(24)),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.black),
            tooltip: 'Add New Property',
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: isDark
              ? null
              : const LinearGradient(
                  colors: [Color(0xFFFFF8E1), Color(0xFFFFFFFF)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
            itemCount: ownedProperties.length,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              final property = ownedProperties[index];
              final images = List<String>.from(property['images'] ?? []);
              final title = property['title'] ?? 'No Title';
              final location = property['location'] ?? '';
              final price = property['price'] ?? 0.0;
              final status = property['status'] ?? 'Unknown';

              return AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.easeInOut,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: isDark ? Colors.grey.shade900 : Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: isDark
                      ? []
                      : [
                          BoxShadow(
                            color: Colors.amber.withOpacity(0.25),
                            blurRadius: 15,
                            offset: const Offset(0, 6),
                          ),
                        ],
                ),
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PropertyDetailsScreen(
                          imageAsset: images.isNotEmpty
                              ? images[0]
                              : 'assets/house1.jpg',
                          title: title,
                          location: location,
                          price: '₹${price.toStringAsFixed(0)}/Month',
                          description:
                              'Spacious and modern property located in the heart of $location.',
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Property Images
                        if (images.isNotEmpty)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: SizedBox(
                              height: 180,
                              child: PageView.builder(
                                itemCount: images.length,
                                controller: PageController(viewportFraction: 0.9),
                                itemBuilder: (context, imgIndex) {
                                  return AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    margin: const EdgeInsets.symmetric(horizontal: 6),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(16),
                                      image: DecorationImage(
                                        image: AssetImage(images[imgIndex]),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        const SizedBox(height: 16),

                        // Property Info
                        Text(
                          title,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: isDark ? Colors.white : Colors.black,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.location_on,
                                size: 18, color: Colors.grey),
                            const SizedBox(width: 4),
                            Text(
                              location,
                              style: TextStyle(
                                color: isDark ? Colors.grey[400] : Colors.grey,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          '₹${price.toStringAsFixed(0)}/Month',
                          style: TextStyle(
                            color: isDark ? Colors.greenAccent : Colors.green,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Status + Actions
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              decoration: BoxDecoration(
                                color: status == 'Rented'
                                    ? Colors.green.shade600
                                    : Colors.orange.shade600,
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: status == 'Rented'
                                        ? Colors.green.withOpacity(0.3)
                                        : Colors.orange.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    status == 'Rented'
                                        ? Icons.check_circle
                                        : Icons.home,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 6),
                                  Text(
                                    status,
                                    style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                _actionIcon(Icons.edit, Colors.blue, isDark, () {}),
                                const SizedBox(width: 8),
                                _actionIcon(Icons.delete, Colors.red, isDark, () {}),
                                const SizedBox(width: 8),
                                _actionIcon(Icons.share, Colors.amber, isDark, () {}),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _actionIcon(
      IconData icon, Color color, bool isDark, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isDark ? Colors.grey.shade800 : color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: isDark ? color.withOpacity(0.8) : color,
          size: 20,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'property_detail_page.dart';

class PropertyListPage extends StatelessWidget {
  final String cityName;
  final String category;
  const PropertyListPage({super.key, required this.cityName, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('$category in $cityName'),
        backgroundColor: Colors.amber[600],
        foregroundColor: Colors.black,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return _PropertyCard(index: index, cityName: cityName, category: category);
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: 10,
      ),
    );
  }
}

class _PropertyCard extends StatelessWidget {
  final int index;
  final String cityName;
  final String category;

  const _PropertyCard({required this.index, required this.cityName, required this.category});

  @override
  Widget build(BuildContext context) {
    final data = _dataFor(category, index, cityName);
    final assetIndex = (index % 7) + 1; // we have house1.jpg..house7.jpg
    final assetPath = 'assets/house$assetIndex.jpg';

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Responsive image with fixed aspect ratio
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.asset(
                assetPath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[200],
                  child: const Center(child: Icon(Icons.image_not_supported)),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.amber[50],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(data.icon, color: Colors.amber[700]),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data.title,
                        style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        data.subtitle,
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(Icons.star, color: Colors.amber[600], size: 16),
                          const SizedBox(width: 4),
                          Text('${4.0 + (index % 3) * 0.2}', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                          const SizedBox(width: 8),
                          Icon(Icons.location_on, color: Colors.grey[600], size: 16),
                          const SizedBox(width: 4),
                          Text('${index + 1} km from city center', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.favorite_border),
                  onPressed: () {},
                )
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => PropertyDetailPage(
                            title: data.title,
                            pricePerMonth: data.subtitle.split('•').last.trim(),
                            locationLine: data.subtitle.split('•').first.trim(),
                            assetImage: assetPath,
                            bedrooms: 2,
                            bathrooms: 2,
                            area: '1,100 sq ft',
                            type: category,
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
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contact request sent. We\'ll reach out soon.')));
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[600], foregroundColor: Colors.black),
                    child: const Text("Contact"),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  _CardData _dataFor(String category, int index, String cityName) {
    // Generate 3-4 unique listings per city with distinct names
    final houseNames = <String>{
      '$cityName Riverside Haven',
      '$cityName Green Meadows 2BHK',
      '$cityName Skyline View Apartment',
      '$cityName Lakefront Residency',
      '$cityName Sunshine Villas',
      '$cityName Heritage Homes',
    }.toList();

    switch (category) {
      case 'Houses':
        final name = houseNames[index % houseNames.length];
        return _CardData(
          title: name,
          subtitle: '$cityName • ₹${(12000 + (index % 4) * 750)} / month',
          icon: Icons.home_outlined,
        );
      case 'Hostels':
        final names = ['${cityName} Boys Hostel', '${cityName} Girls Hostel', '${cityName} Working Women Hostel', '${cityName} Student Inn'];
        return _CardData(
          title: names[index % names.length],
          subtitle: '$cityName • ₹${(8000 + (index % 4) * 500)} / month',
          icon: Icons.apartment,
        );
      case 'PGs':
        final names = ['${cityName} Elite PG', '${cityName} Comfort PG', '${cityName} Prime PG', '${cityName} Cozy PG'];
        return _CardData(
          title: names[index % names.length],
          subtitle: '$cityName • ₹${(6000 + (index % 4) * 400)} / month',
          icon: Icons.meeting_room,
        );
      default:
        final names = ['${cityName} Tech Park Shop', '${cityName} Market Front Office', '${cityName} Downtown Workspace'];
        return _CardData(
          title: names[index % names.length],
          subtitle: '$cityName • ₹${(10000 + (index % 4) * 1000)} / month',
          icon: Icons.business,
        );
    }
  }
}

class _CardData {
  final String title;
  final String subtitle;
  final IconData icon;
  const _CardData({required this.title, required this.subtitle, required this.icon});
}



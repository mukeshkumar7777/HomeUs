import 'package:flutter/material.dart';
import 'property_details.dart';
import 'wishlist_screen.dart';
import 'chat_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  String _relativeTime(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inDays > 365) {
      return '${(diff.inDays / 365).floor()} years ago';
    } else if (diff.inDays > 30) {
      return '${(diff.inDays / 30).floor()} months ago';
    } else if (diff.inDays > 7) {
      return '${(diff.inDays / 7).floor()} weeks ago';
    } else if (diff.inDays > 0) {
      return '${diff.inDays} days ago';
    } else if (diff.inHours > 0) {
      return '${diff.inHours} hours ago';
    } else if (diff.inMinutes > 0) {
      return '${diff.inMinutes} minutes ago';
    } else {
      return 'just now';
    }
  }

  final List<Map<String, dynamic>> _properties = [
    {
      'images': ['assets/house 1.jpg', 'assets/house2.jpg', 'assets/house3.jpg'],
      'title': 'Cozy Apartment',
      'description': 'A nice cozy apartment in the city center.',
      'price': 15000.0,
      'transactionType': 'Rent',
      'createdAt': DateTime.now().subtract(const Duration(days: 1)),
      'ownerName': 'Srinivas',
      'location': '1BHK Independent House near Hal House, Hyderabad',
      'size': '600 sq ft',
      'type': 'Semi Furnished',
      'phone': '+91 1234567890',
    },
    {
      'images': ['assets/house4.jpg', 'assets/house5.jpg'],
      'title': 'Modern Flat',
      'description': 'Fully furnished modern flat with great views.',
      'price': 20000.0,
      'transactionType': 'Rent',
      'createdAt': DateTime.now().subtract(const Duration(days: 2)),
      'ownerName': 'Ravi',
      'location': '2BHK Apartment in Kondapur, Hyderabad',
      'size': '800 sq ft',
      'type': 'Fully Furnished',
      'phone': '+91 0987654321',
    },
    {
      'images': ['assets/house6.jpg', 'assets/house7.jpg', 'assets/2bhk.jpg'],
      'title': 'Studio Apartment',
      'description': 'Compact studio for singles.',
      'price': 10000.0,
      'transactionType': 'Rent',
      'createdAt': DateTime.now().subtract(const Duration(days: 7)),
      'ownerName': 'Priya',
      'location': 'Studio Apartment, Gachibowli',
      'size': '500 sq ft',
      'type': 'Unfurnished',
      'phone': '+91 1122334455',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Explore Properties'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(context: context, delegate: _PropertySearchDelegate());
            },
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () {
                },
              ),
              Positioned(
                right: 8,
                top: 8,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  constraints: const BoxConstraints(
                    minWidth: 12,
                    minHeight: 12,
                  ),
                  child: const Text(
                    '1',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: _buildExploreList(),
    );
  }

  Widget _buildExploreList() {
    if (_properties.isEmpty) {
      return const Center(child: Text('No properties available yet.'));
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Explore Nearby Properties',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _properties.length,
              itemBuilder: (context, index) {
                final data = _properties[index];
                final images = List<String>.from(data['images'] ?? []);
                final title = data['title'] ?? 'No Title';
                final description = data['description'] ?? 'No description';
                final price = (data['price'] as double?) ?? 0.0;
                final transactionType = data['transactionType'] ?? 'Rent';
                final createdAt = data['createdAt'] as DateTime?;
                final dateStr = createdAt != null ? _relativeTime(createdAt) : 'Unknown';
                final agent = data['ownerName'] ?? 'Anonymous';
                final location = data['location'] ?? title;
                final size = data['size'] ?? 'Unknown sq ft';
                final type = data['type'] ?? transactionType;
                final phone = data['phone'] ?? '';

                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PropertyDetailsScreen(
                          imageAsset: images.isNotEmpty ? images[0] : 'assets/house 1.jpg',
                          title: title,
                          location: location,
                          price: '₹${price.toStringAsFixed(0)}/${transactionType == 'Rent' ? 'Month' : ''}',
                          description: description,
                        ),
                      ),
                    );
                  },
                  child: Card(
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
                        // Images row (up to 3 images)
                        if (images.isNotEmpty)
                          SizedBox(
                            height: 100,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: images.length > 3 ? 3 : images.length,
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
                          )
                        else
                          // No photos placeholder
                          Container(
                            height: 100,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.house, size: 40, color: Colors.grey),
                                  SizedBox(height: 8),
                                  Text('No photos', style: TextStyle(color: Colors.grey)),
                                ],
                              ),
                            ),
                          ),
                        const SizedBox(height: 12),
                        // Details
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    '$type $size',
                                    style: const TextStyle(fontWeight: FontWeight.w600),
                                  ),
                                  Text(dateStr),
                                  Text(
                                    location,
                                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            Text(
                              '₹${price.toStringAsFixed(0)}/${transactionType == 'Rent' ? 'Month' : ''}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.green,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        // Agent info
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xFFF7C948),
                              child: Text(
                                agent.isNotEmpty ? agent[0] : '?',
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(agent),
                                  const Text('View Number', style: TextStyle(fontSize: 12, color: Colors.grey)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.phone, size: 20),
                                  onPressed: phone.isNotEmpty
                                      ? () {
                                          // TODO: Implement call (e.g., using url_launcher)
                                        }
                                      : null,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.message, size: 20),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => const ChatScreen()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                        // Like button
                        Align(
                          alignment: Alignment.centerRight,
                          child: IconButton(
                            icon: const Icon(Icons.favorite_border, color: Colors.grey),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => const WishlistScreen()),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  )
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// Simple search delegate for demonstration
class _PropertySearchDelegate extends SearchDelegate {
  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // TODO: Implement real suggestions
    return const ListTile(title: Text('Search suggestions coming soon'));
  }

  @override
  Widget buildResults(BuildContext context) {
    // TODO: Implement search results
    return const Center(child: Text('Search results'));
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../localization.dart';

class SavedScreen extends StatefulWidget {
  final String language;
  const SavedScreen({super.key, required this.language});

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  final List<Map<String, String>> items = const [
    {'id': 'p1', 'title': '2BHK Flat - Hyderabad', 'subtitle': 'Gachibowli • 1,050 sqft • ₹72L', 'image': 'assets/flat.png'},
    {'id': 'p2', 'title': '3BHK Villa - Vizag', 'subtitle': 'MVP Colony • 2,100 sqft • ₹1.55Cr', 'image': 'assets/villas.png'},
    {'id': 'p3', 'title': '1BHK Apartment - Vijayawada', 'subtitle': 'Benz Circle • 650 sqft • ₹32L', 'image': 'assets/appartment.png'},
    {'id': 'p4', 'title': 'Hostel - Surampalem', 'subtitle': 'ADB road • 420 sqft • ₹50K', 'image': 'assets/hostel.png'},
  ];

  Set<String> favoriteIds = {};

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final list = prefs.getStringList('favoriteIds') ?? <String>[];
    setState(() {
      favoriteIds = list.toSet();
    });
  }

  Future<void> _toggleFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final current = prefs.getStringList('favoriteIds') ?? <String>[];
    final set = current.toSet();
    if (set.contains(id)) {
      set.remove(id);
    } else {
      set.add(id);
    }
    await prefs.setStringList('favoriteIds', set.toList());
    await _loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    final texts = localizedText(widget.language);

    return Scaffold(
      appBar: AppBar(title: Text(texts["saved"]!)),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          final item = items[index];
          final isFav = favoriteIds.contains(item['id']!);
          return Card(
            elevation: 2,
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Image.network(
                    item['image']!,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      color: Colors.grey.shade300,
                      child: const Center(child: Icon(Icons.image_not_supported)),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
                  child: Row(
                    children: [
                      Expanded(child: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold))),
                      IconButton(
                        tooltip: isFav ? 'Remove from favorites' : 'Add to favorites',
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border, color: isFav ? Colors.red : null),
                        onPressed: () => _toggleFavorite(item['id']!),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
                  child: Text(item['subtitle']!, style: TextStyle(color: Theme.of(context).textTheme.bodySmall?.color)),
                ),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemCount: items.length,
      ),
    );
  }
}
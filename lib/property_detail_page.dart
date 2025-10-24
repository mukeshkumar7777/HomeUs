import 'package:flutter/material.dart';

class PropertyDetailPage extends StatelessWidget {
  final String title;
  final String pricePerMonth; // e.g. ₹32000/month
  final String locationLine;
  final String assetImage; // lib/assets/houseX.jpg
  final int bedrooms;
  final int bathrooms;
  final String area; // e.g. 1,200 sq ft
  final String type; // e.g. Apartment

  const PropertyDetailPage({
    super.key,
    required this.title,
    required this.pricePerMonth,
    required this.locationLine,
    required this.assetImage,
    required this.bedrooms,
    required this.bathrooms,
    required this.area,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Color(0xFFF7C948), foregroundColor: Colors.black, title: Text(title)),
      body: ListView(
        children: [
          // Header image
          AspectRatio(
            aspectRatio: 16/9,
            child: Image.asset(assetImage, fit: BoxFit.cover),
          ),
          const SizedBox(height: 12),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                      const SizedBox(height: 6),
                      Row(children: [
                        Icon(Icons.place, size: 18, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        Expanded(child: Text(locationLine, style: TextStyle(color: Colors.grey[700]))),
                      ]),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(pricePerMonth, style: TextStyle(color: Colors.amber[700], fontWeight: FontWeight.w800)),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Wrap(
              spacing: 12,
              runSpacing: 12,
              children: [
                _pill(icon: Icons.bed, label: '$bedrooms bedrooms'),
                _pill(icon: Icons.bathtub, label: '$bathrooms bathrooms'),
                _pill(icon: Icons.straighten, label: area),
                _pill(icon: Icons.apartment, label: type),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _Section(title: 'Description', child: Text('Sleek modern loft with floor-to-ceiling windows and city skyline views', style: TextStyle(color: Colors.grey[800]))),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: _Section(
              title: 'Amenities',
              child: Wrap(spacing: 8, runSpacing: 8, children: const [
                _AmenityChip(label: 'City Views'),
                _AmenityChip(label: 'Rooftop Access'),
                _AmenityChip(label: 'Gym'),
              ]),
            ),
          ),
          const SizedBox(height: 24),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved to favorites')));
                    },
                    icon: const Icon(Icons.favorite_border),
                    label: const Text('Save'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Contact request sent. We\'ll reach out soon.')));
                    },
                    icon: const Icon(Icons.call),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.amber[600], foregroundColor: Colors.black),
                    label: const Text('Contact'),
                  ),
                ),
              ]),
            ),
          )
        ],
      ),
    );
  }

  static Widget _pill({required IconData icon, required String label}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 8, spreadRadius: 1)],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 18, color: Colors.grey[800]),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),
      ]),
    );
  }
}

class _Section extends StatelessWidget {
  final String title;
  final Widget child;
  const _Section({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
      const SizedBox(height: 10),
      Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 8, spreadRadius: 1)],
        ),
        child: child,
      ),
    ]);
  }
}

class _AmenityChip extends StatelessWidget {
  final String label;
  const _AmenityChip({required this.label});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.grey[300]!),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, spreadRadius: 1)],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(Icons.verified, size: 16, color: Colors.amber[700]),
        const SizedBox(width: 6),
        Text(label),
      ]),
    );
  }
}



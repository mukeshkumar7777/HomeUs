import 'package:flutter/material.dart';

class PropertyCard extends StatelessWidget {
  final String price;
  final String beds;
  final String baths;
  final String lotSize;
  final String address;

  const PropertyCard({
    super.key,
    required this.price,
    required this.beds,
    required this.baths,
    required this.lotSize,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("For sale", style: TextStyle(color: Colors.green)),
              const SizedBox(height: 4),
              Text(
                price,
                style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              const SizedBox(height: 4),
              Text("$beds bed  $baths bath  $lotSize"),
              const SizedBox(height: 4),
              Text(address, style: const TextStyle(color: Colors.grey)),
              const SizedBox(height: 8),
              ElevatedButton(
                onPressed: () {},
                child: const Text("Contact agent"),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.black,
                  side: const BorderSide(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'filter_screen.dart';

class FilterBar extends StatelessWidget {
  const FilterBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        children: [
          _buildFilterButton("Filters", () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const FilterScreen(),
              ),
            );
          }),
          _buildFilterButton("Price", () {}),
          _buildFilterButton("Rooms", () {}),
          _buildFilterButton("Property Type", () {}),
        ],
      ),
    );
  }

  Widget _buildFilterButton(String label, VoidCallback onPressed) {
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: OutlinedButton(
        onPressed: onPressed,
        child: Text(label),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          side: const BorderSide(color: Colors.grey),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}

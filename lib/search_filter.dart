

import 'package:flutter/material.dart';
// Adjust path accordingly

class SearchFilterBar extends StatelessWidget {
  final TextEditingController? controller;

  const SearchFilterBar({super.key, this.controller});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final theme = Theme.of(context);
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: controller,
            style: TextStyle(color: theme.colorScheme.onSurface),
            decoration: InputDecoration(
              hintText: "Search houses, rooms..",
              hintStyle: TextStyle(
                color: Colors.grey[600],
              ),
              prefixIcon: const Icon(Icons.search, color: Colors.grey),
              filled: false,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 0),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.grey),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: const BorderSide(color: Colors.grey),
              ),
            ),
          ),
        ),
        SizedBox(width: screenWidth < 400 ? 6 : 10),
      ],
    );
  }
}

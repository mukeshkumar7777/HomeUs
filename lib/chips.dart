import 'package:flutter/material.dart';

class CategoryChips extends StatelessWidget {
  final Function(String) onCategorySelected;
  final String selected;

  const CategoryChips({
    super.key,
    required this.onCategorySelected,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    final categories = ["Recently Watched", "Popular", "New Arrivals"];

    return Wrap(
      spacing: 8.0,
      children: categories.map((category) {
        final isSelected = category == selected;
        return ChoiceChip(
          label: Text(category),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              onCategorySelected(category);
            }
          },
        );
      }).toList(),
    );
  }
}

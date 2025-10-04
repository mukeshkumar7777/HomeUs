import 'package:flutter/material.dart';

class CategoryDetailsScreen extends StatelessWidget {
  final String category;

  const CategoryDetailsScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(category),
        backgroundColor: Colors.white,
        elevation: 1,
        foregroundColor: Colors.black,
      ),
      body: Center(
        child: Text(
          "Showing results for \"$category\"",
          style: const TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
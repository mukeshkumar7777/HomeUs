import 'package:flutter/material.dart';

class MapTileToggle extends StatelessWidget {
  final String tileStyle;
  final ValueChanged<String> onChange;
  const MapTileToggle({super.key, required this.tileStyle, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      right: 16,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 6, spreadRadius: 1)],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              tooltip: 'Streets',
              onPressed: () => onChange('streets'),
              icon: Icon(Icons.map, color: tileStyle == 'streets' ? Colors.green[700] : Colors.grey),
            ),
            IconButton(
              tooltip: 'Satellite',
              onPressed: () => onChange('satellite'),
              icon: Icon(Icons.satellite_alt, color: tileStyle == 'satellite' ? Colors.green[700] : Colors.grey),
            ),
            IconButton(
              tooltip: 'Hybrid',
              onPressed: () => onChange('hybrid'),
              icon: Icon(Icons.layers, color: tileStyle == 'hybrid' ? Colors.green[700] : Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}



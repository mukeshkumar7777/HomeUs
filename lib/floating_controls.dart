import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart' as osm;

class DraggableFloatingControls extends StatelessWidget {
  final Offset offset;
  final void Function(Offset) onOffset;
  final osm.MapController controller;
  final VoidCallback onRoute;
  const DraggableFloatingControls({super.key, required this.offset, required this.onOffset, required this.controller, required this.onRoute});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: offset.dx,
      top: offset.dy,
      child: GestureDetector(
        onPanUpdate: (details) => onOffset(offset + details.delta),
        child: Column(
          children: [
            FloatingActionButton(
              heroTag: 'zoom_in',
              backgroundColor: Colors.white,
              onPressed: () {
                final newZoom = (controller.camera.zoom + 1).clamp(5.5, 20) as double;
                controller.move(controller.camera.center, newZoom);
              },
              child: const Icon(Icons.add, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: 'zoom_out',
              backgroundColor: Colors.white,
              onPressed: () {
                final newZoom = (controller.camera.zoom - 1).clamp(3.0, 20) as double;
                controller.move(controller.camera.center, newZoom);
              },
              child: const Icon(Icons.remove, color: Colors.black87),
            ),
            const SizedBox(height: 12),
            FloatingActionButton(
              heroTag: 'route',
              backgroundColor: Colors.blue,
              onPressed: onRoute,
              child: const Icon(Icons.near_me, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}



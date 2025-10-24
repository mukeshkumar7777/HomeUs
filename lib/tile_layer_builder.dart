import 'package:flutter_map/flutter_map.dart' as osm;

osm.TileLayer buildTileLayer(String tileStyle) {
  switch (tileStyle) {
    case 'satellite':
      // Using a satellite tile provider (example: Esri World Imagery)
      return osm.TileLayer(
        urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
        userAgentPackageName: 'dev.homeus.app',
        maxZoom: 18,
        additionalOptions: const {
          'attribution': '© Esri',
        },
      );
    case 'hybrid':
      // Hybrid: satellite with labels
      return osm.TileLayer(
        urlTemplate: 'https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}',
        userAgentPackageName: 'dev.homeus.app',
        maxZoom: 18,
        additionalOptions: const {
          'variant': 'hybrid',
          'attribution': '© Esri',
        },
      );
    case 'terrain':
      // Terrain tiles
      return osm.TileLayer(
        urlTemplate: 'https://tile.opentopomap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.homeus.app',
        maxZoom: 17,
        additionalOptions: const {
          'attribution': '© OpenTopoMap contributors',
        },
      );
    case 'streets':
    default:
      // Using alternative tile provider to avoid OSM blocking
      return osm.TileLayer(
        urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
        userAgentPackageName: 'dev.homeus.app',
        maxZoom: 19,
        additionalOptions: const {
          'attribution': '© OpenStreetMap contributors',
        },
        // Add cache configuration
        tileProvider: osm.NetworkTileProvider(),
      );
  }
}

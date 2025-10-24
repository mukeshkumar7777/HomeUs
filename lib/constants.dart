import 'package:latlong2/latlong.dart' as latlng;

// Andhra Pradesh map constants
const double apSouth = 12.5;
const double apNorth = 19.5;
const double apWest = 76.5;
const double apEast = 85.0;

final latlng.LatLng apCenter = latlng.LatLng(16.5062, 80.6480);

bool isWithinAp(double lat, double lng) {
  return lat >= apSouth && lat <= apNorth && lng >= apWest && lng <= apEast;
}

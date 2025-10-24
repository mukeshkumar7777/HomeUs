import 'package:geocoding/geocoding.dart';

class City {
  final String name;
  final String country;
  final double latitude;
  final double longitude;
  final String countryCode;
  final int population;

  City({
    required this.name,
    required this.country,
    required this.latitude,
    required this.longitude,
    required this.countryCode,
    required this.population,
  });

  factory City.fromJson(Map<String, dynamic> json) {
    return City(
      name: json['name'] ?? '',
      country: json['country'] ?? '',
      latitude: (json['latitude'] ?? 0).toDouble(),
      longitude: (json['longitude'] ?? 0).toDouble(),
      countryCode: json['countryCode'] ?? '',
      population: json['population'] ?? 0,
    );
  }
}

class CityService {
  // Comprehensive list of major cities worldwide
  static final List<City> _cities = [
    // North America
    City(name: 'New York', country: 'United States', latitude: 40.7128, longitude: -74.0060, countryCode: 'US', population: 8336817),
    City(name: 'Los Angeles', country: 'United States', latitude: 34.0522, longitude: -118.2437, countryCode: 'US', population: 3979576),
    City(name: 'Chicago', country: 'United States', latitude: 41.8781, longitude: -87.6298, countryCode: 'US', population: 2693976),
    City(name: 'Houston', country: 'United States', latitude: 29.7604, longitude: -95.3698, countryCode: 'US', population: 2320268),
    City(name: 'Phoenix', country: 'United States', latitude: 33.4484, longitude: -112.0740, countryCode: 'US', population: 1680992),
    City(name: 'Philadelphia', country: 'United States', latitude: 39.9526, longitude: -75.1652, countryCode: 'US', population: 1584064),
    City(name: 'San Antonio', country: 'United States', latitude: 29.4241, longitude: -98.4936, countryCode: 'US', population: 1547253),
    City(name: 'San Diego', country: 'United States', latitude: 32.7157, longitude: -117.1611, countryCode: 'US', population: 1423851),
    City(name: 'Dallas', country: 'United States', latitude: 32.7767, longitude: -96.7970, countryCode: 'US', population: 1343573),
    City(name: 'San Jose', country: 'United States', latitude: 37.3382, longitude: -121.8863, countryCode: 'US', population: 1035317),
    City(name: 'Toronto', country: 'Canada', latitude: 43.6532, longitude: -79.3832, countryCode: 'CA', population: 2930000),
    City(name: 'Vancouver', country: 'Canada', latitude: 49.2827, longitude: -123.1207, countryCode: 'CA', population: 675218),
    City(name: 'Montreal', country: 'Canada', latitude: 45.5017, longitude: -73.5673, countryCode: 'CA', population: 1780000),
    City(name: 'Mexico City', country: 'Mexico', latitude: 19.4326, longitude: -99.1332, countryCode: 'MX', population: 9209944),

    // Europe
    City(name: 'London', country: 'United Kingdom', latitude: 51.5074, longitude: -0.1278, countryCode: 'GB', population: 8982000),
    City(name: 'Paris', country: 'France', latitude: 48.8566, longitude: 2.3522, countryCode: 'FR', population: 2161000),
    City(name: 'Berlin', country: 'Germany', latitude: 52.5200, longitude: 13.4050, countryCode: 'DE', population: 3669491),
    City(name: 'Madrid', country: 'Spain', latitude: 40.4168, longitude: -3.7038, countryCode: 'ES', population: 3223334),
    City(name: 'Rome', country: 'Italy', latitude: 41.9028, longitude: 12.4964, countryCode: 'IT', population: 2873000),
    City(name: 'Amsterdam', country: 'Netherlands', latitude: 52.3676, longitude: 4.9041, countryCode: 'NL', population: 872680),
    City(name: 'Barcelona', country: 'Spain', latitude: 41.3851, longitude: 2.1734, countryCode: 'ES', population: 1621537),
    City(name: 'Vienna', country: 'Austria', latitude: 48.2082, longitude: 16.3738, countryCode: 'AT', population: 1911191),
    City(name: 'Prague', country: 'Czech Republic', latitude: 50.0755, longitude: 14.4378, countryCode: 'CZ', population: 1301132),
    City(name: 'Stockholm', country: 'Sweden', latitude: 59.3293, longitude: 18.0686, countryCode: 'SE', population: 975551),
    City(name: 'Copenhagen', country: 'Denmark', latitude: 55.6761, longitude: 12.5683, countryCode: 'DK', population: 632340),
    City(name: 'Zurich', country: 'Switzerland', latitude: 47.3769, longitude: 8.5417, countryCode: 'CH', population: 415367),
    City(name: 'Brussels', country: 'Belgium', latitude: 50.8503, longitude: 4.3517, countryCode: 'BE', population: 1218255),
    City(name: 'Warsaw', country: 'Poland', latitude: 52.2297, longitude: 21.0122, countryCode: 'PL', population: 1790658),
    City(name: 'Budapest', country: 'Hungary', latitude: 47.4979, longitude: 19.0402, countryCode: 'HU', population: 1752286),

    // Asia
    City(name: 'Tokyo', country: 'Japan', latitude: 35.6762, longitude: 139.6503, countryCode: 'JP', population: 13929286),
    City(name: 'Shanghai', country: 'China', latitude: 31.2304, longitude: 121.4737, countryCode: 'CN', population: 24870895),
    City(name: 'Beijing', country: 'China', latitude: 39.9042, longitude: 116.4074, countryCode: 'CN', population: 21540000),
    City(name: 'Seoul', country: 'South Korea', latitude: 37.5665, longitude: 126.9780, countryCode: 'KR', population: 9720846),
    City(name: 'Hong Kong', country: 'Hong Kong', latitude: 22.3193, longitude: 114.1694, countryCode: 'HK', population: 7500700),
    City(name: 'Singapore', country: 'Singapore', latitude: 1.3521, longitude: 103.8198, countryCode: 'SG', population: 5453600),
    City(name: 'Bangkok', country: 'Thailand', latitude: 13.7563, longitude: 100.5018, countryCode: 'TH', population: 10539000),
    City(name: 'Jakarta', country: 'Indonesia', latitude: -6.2088, longitude: 106.8456, countryCode: 'ID', population: 10560000),
    City(name: 'Kuala Lumpur', country: 'Malaysia', latitude: 3.1390, longitude: 101.6869, countryCode: 'MY', population: 1588750),
    City(name: 'Manila', country: 'Philippines', latitude: 14.5995, longitude: 120.9842, countryCode: 'PH', population: 13484425),
    City(name: 'Mumbai', country: 'India', latitude: 19.0760, longitude: 72.8777, countryCode: 'IN', population: 12442373),
    City(name: 'Delhi', country: 'India', latitude: 28.7041, longitude: 77.1025, countryCode: 'IN', population: 32941000),
    City(name: 'Bangalore', country: 'India', latitude: 12.9716, longitude: 77.5946, countryCode: 'IN', population: 12479904),
    City(name: 'Chennai', country: 'India', latitude: 13.0827, longitude: 80.2707, countryCode: 'IN', population: 11440000),
    City(name: 'Kolkata', country: 'India', latitude: 22.5726, longitude: 88.3639, countryCode: 'IN', population: 14974073),
    // India - Andhra Pradesh (major cities)
    City(name: 'Visakhapatnam', country: 'India', latitude: 17.6868, longitude: 83.2185, countryCode: 'IN', population: 2035922),
    City(name: 'Vijayawada', country: 'India', latitude: 16.5062, longitude: 80.6480, countryCode: 'IN', population: 1048240),
    City(name: 'Guntur', country: 'India', latitude: 16.3067, longitude: 80.4365, countryCode: 'IN', population: 743354),
    City(name: 'Nellore', country: 'India', latitude: 14.4426, longitude: 79.9865, countryCode: 'IN', population: 600869),
    City(name: 'Kurnool', country: 'India', latitude: 15.8281, longitude: 78.0373, countryCode: 'IN', population: 484327),
    City(name: 'Rajahmundry', country: 'India', latitude: 17.0005, longitude: 81.8040, countryCode: 'IN', population: 414146),
    City(name: 'Tirupati', country: 'India', latitude: 13.6288, longitude: 79.4192, countryCode: 'IN', population: 374260),
    City(name: 'Kakinada', country: 'India', latitude: 16.9891, longitude: 82.2475, countryCode: 'IN', population: 443903),
    City(name: 'Eluru', country: 'India', latitude: 16.7107, longitude: 81.0952, countryCode: 'IN', population: 350000),
    City(name: 'Kadapa', country: 'India', latitude: 14.4673, longitude: 78.8242, countryCode: 'IN', population: 344893),
    City(name: 'Vizianagaram', country: 'India', latitude: 18.1067, longitude: 83.3956, countryCode: 'IN', population: 228025),
    City(name: 'Anantapur', country: 'India', latitude: 14.6819, longitude: 77.6006, countryCode: 'IN', population: 340613),
    City(name: 'Ongole', country: 'India', latitude: 15.5057, longitude: 80.0499, countryCode: 'IN', population: 208344),
    City(name: 'Srikakulam', country: 'India', latitude: 18.2969, longitude: 83.8966, countryCode: 'IN', population: 165000),
    City(name: 'Chittoor', country: 'India', latitude: 13.2172, longitude: 79.1003, countryCode: 'IN', population: 189332),
    City(name: 'Amaravati', country: 'India', latitude: 16.5730, longitude: 80.3734, countryCode: 'IN', population: 103000),
    City(name: 'Machilipatnam', country: 'India', latitude: 16.1875, longitude: 81.1389, countryCode: 'IN', population: 205000),
    City(name: 'Tadepalligudem', country: 'India', latitude: 16.8130, longitude: 81.5212, countryCode: 'IN', population: 130348),
    City(name: 'Tenali', country: 'India', latitude: 16.2430, longitude: 80.6400, countryCode: 'IN', population: 199345),

    // Middle East & Africa
    City(name: 'Dubai', country: 'United Arab Emirates', latitude: 25.2048, longitude: 55.2708, countryCode: 'AE', population: 3331420),
    City(name: 'Riyadh', country: 'Saudi Arabia', latitude: 24.7136, longitude: 46.6753, countryCode: 'SA', population: 7676654),
    City(name: 'Cairo', country: 'Egypt', latitude: 30.0444, longitude: 31.2357, countryCode: 'EG', population: 20484965),
    City(name: 'Istanbul', country: 'Turkey', latitude: 41.0082, longitude: 28.9784, countryCode: 'TR', population: 15519267),
    City(name: 'Tehran', country: 'Iran', latitude: 35.6892, longitude: 51.3890, countryCode: 'IR', population: 9150000),
    City(name: 'Lagos', country: 'Nigeria', latitude: 6.5244, longitude: 3.3792, countryCode: 'NG', population: 15388000),
    City(name: 'Johannesburg', country: 'South Africa', latitude: -26.2041, longitude: 28.0473, countryCode: 'ZA', population: 5634800),
    City(name: 'Cape Town', country: 'South Africa', latitude: -33.9249, longitude: 18.4241, countryCode: 'ZA', population: 4618000),
    City(name: 'Nairobi', country: 'Kenya', latitude: -1.2921, longitude: 36.8219, countryCode: 'KE', population: 4397073),
    City(name: 'Casablanca', country: 'Morocco', latitude: 33.5731, longitude: -7.5898, countryCode: 'MA', population: 3359818),

    // South America
    City(name: 'São Paulo', country: 'Brazil', latitude: -23.5505, longitude: -46.6333, countryCode: 'BR', population: 12396372),
    City(name: 'Rio de Janeiro', country: 'Brazil', latitude: -22.9068, longitude: -43.1729, countryCode: 'BR', population: 6747815),
    City(name: 'Buenos Aires', country: 'Argentina', latitude: -34.6118, longitude: -58.3960, countryCode: 'AR', population: 3075646),
    City(name: 'Lima', country: 'Peru', latitude: -12.0464, longitude: -77.0428, countryCode: 'PE', population: 10750000),
    City(name: 'Bogotá', country: 'Colombia', latitude: 4.7110, longitude: -74.0721, countryCode: 'CO', population: 7743955),
    City(name: 'Santiago', country: 'Chile', latitude: -33.4489, longitude: -70.6693, countryCode: 'CL', population: 7035000),
    City(name: 'Caracas', country: 'Venezuela', latitude: 10.4806, longitude: -66.9036, countryCode: 'VE', population: 2843598),
    City(name: 'Quito', country: 'Ecuador', latitude: -0.1807, longitude: -78.4678, countryCode: 'EC', population: 2011388),

    // Oceania
    City(name: 'Sydney', country: 'Australia', latitude: -33.8688, longitude: 151.2093, countryCode: 'AU', population: 5312163),
    City(name: 'Melbourne', country: 'Australia', latitude: -37.8136, longitude: 144.9631, countryCode: 'AU', population: 5078193),
    City(name: 'Brisbane', country: 'Australia', latitude: -27.4698, longitude: 153.0251, countryCode: 'AU', population: 2480000),
    City(name: 'Perth', country: 'Australia', latitude: -31.9505, longitude: 115.8605, countryCode: 'AU', population: 2080000),
    City(name: 'Auckland', country: 'New Zealand', latitude: -36.8485, longitude: 174.7633, countryCode: 'NZ', population: 1657000),
    City(name: 'Wellington', country: 'New Zealand', latitude: -41.2865, longitude: 174.7762, countryCode: 'NZ', population: 212700),
  ];

  static List<City> searchCities(String query) {
    if (query.isEmpty) return [];
    
    final lowercaseQuery = query.toLowerCase();
    return _cities.where((city) {
      return city.name.toLowerCase().contains(lowercaseQuery) ||
             city.country.toLowerCase().contains(lowercaseQuery) ||
             city.name.toLowerCase().startsWith(lowercaseQuery);
    }).toList();
  }

  static List<City> getAllCities() {
    return List.from(_cities);
  }

  // Andhra Pradesh helper
  static final Set<String> _andhraPradeshCityNames = {
    'Visakhapatnam',
    'Vijayawada',
    'Guntur',
    'Nellore',
    'Kurnool',
    'Rajahmundry',
    'Tirupati',
    'Kakinada',
    'Eluru',
    'Kadapa',
    'Vizianagaram',
    'Anantapur',
    'Ongole',
    'Srikakulam',
    'Chittoor',
    'Amaravati',
    'Machilipatnam',
    'Tadepalligudem',
    'Tenali',
  };

  static List<City> getAndhraPradeshCities() {
    return _cities
        .where((c) => c.countryCode == 'IN' && _andhraPradeshCityNames.contains(c.name))
        .toList();
  }

  static List<City> searchAndhraPradeshCities(String query) {
    final lower = query.toLowerCase();
    return getAndhraPradeshCities()
        .where((c) => c.name.toLowerCase().contains(lower))
        .toList();
  }

  static City? findCityByName(String cityName) {
    try {
      return _cities.firstWhere(
        (city) => city.name.toLowerCase() == cityName.toLowerCase(),
      );
    } catch (e) {
      return null;
    }
  }

  static Future<Map<String, double>?> getCoordinatesFromAddress(String address) async {
    try {
      List<Location> locations = await locationFromAddress(address);
      if (locations.isNotEmpty) {
        Location location = locations[0];
        return {
          'latitude': location.latitude,
          'longitude': location.longitude,
        };
      }
    } catch (e) {
      print('Error getting coordinates: $e');
    }
    return null;
  }

  static Future<String> getAddressFromCoordinates(double lat, double lng) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(lat, lng);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        return '${place.locality}, ${place.administrativeArea}, ${place.country}';
      }
    } catch (e) {
      print('Error getting address: $e');
    }
    return 'Unknown Location';
  }
}

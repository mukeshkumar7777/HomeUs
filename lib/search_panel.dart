import 'package:flutter/material.dart';
import 'city_service.dart';

class MapSearchPanel extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onSubmitted;
  final VoidCallback onMyLocation;
  final List<City> results;
  final bool showResults;
  final ValueChanged<City> onSelectCity;

  const MapSearchPanel({
    super.key,
    required this.onChanged,
    required this.onSubmitted,
    required this.onMyLocation,
    required this.results,
    required this.showResults,
    required this.onSelectCity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.green[50],
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  onChanged: onChanged,
                  onSubmitted: onSubmitted,
                  decoration: InputDecoration(
                    hintText: 'Search cities...',
                    prefixIcon: const Icon(Icons.search, color: Colors.green),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: Colors.green[600]!, width: 2),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: onMyLocation,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(color: Colors.green[200]!),
                    boxShadow: [
                      BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 6, spreadRadius: 1),
                    ],
                  ),
                  child: const Icon(Icons.my_location, color: Colors.green),
                ),
              ),
            ],
          ),
          if (showResults && results.isNotEmpty)
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(0.3), spreadRadius: 1, blurRadius: 5),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: results.length > 5 ? 5 : results.length,
                itemBuilder: (context, index) {
                  final city = results[index];
                  return ListTile(
                    leading: Icon(Icons.location_city, color: Colors.green[600]),
                    title: Text(city.name),
                    subtitle: Text('${city.country} • Population: ${city.population.toString().replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (m) => '${m[1]},')}'),
                    onTap: () => onSelectCity(city),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}



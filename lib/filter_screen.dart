import 'package:flutter/material.dart';
import 'property_list_page.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  bool rent = true; // Buy/Rent
  String propertyType = 'Houses';
  String frequency = 'Monthly';
  RangeValues price = const RangeValues(0, 10000);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Filter'),
        actions: [
          TextButton(onPressed: () {
            setState(() {
              rent = true;
              propertyType = 'Residential';
              frequency = 'Monthly';
              price = const RangeValues(0, 10000);
            });
          }, child: const Text('Reset')),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Buy / Rent
            Row(children: [
              Expanded(child: _seg('Buy', !rent, () => setState(() => rent = false))),
              const SizedBox(width: 16),
              Expanded(child: _seg('Rent', rent, () => setState(() => rent = true))),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('Property types'),
            const SizedBox(height: 12),
            Row(children: [
              Expanded(child: _seg('Houses', propertyType == 'Houses', () {
                setState(() => propertyType = 'Houses');
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PropertyListPage(cityName: 'Nearby', category: 'Houses')));
              })),
              const SizedBox(width: 16),
              Expanded(child: _seg('Hostels', propertyType == 'Hostels', () {
                setState(() => propertyType = 'Hostels');
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PropertyListPage(cityName: 'Nearby', category: 'Hostels')));
              })),
            ]),
            const SizedBox(height: 16),
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              _QuickType(icon: Icons.home, label: 'Houses', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PropertyListPage(cityName: 'Nearby', category: 'Houses')));
              }),
              _QuickType(icon: Icons.apartment, label: 'Hostels', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PropertyListPage(cityName: 'Nearby', category: 'Hostels')));
              }),
              _QuickType(icon: Icons.meeting_room, label: 'PGs', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PropertyListPage(cityName: 'Nearby', category: 'PGs')));
              }),
              _QuickType(icon: Icons.business, label: 'Commercial', onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const PropertyListPage(cityName: 'Nearby', category: 'Commercial')));
              }),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('Rental frequency'),
            const SizedBox(height: 12),
            Wrap(spacing: 12, children: [
              _choice('Yearly', selected: frequency == 'Yearly', onTap: () => setState(() => frequency = 'Yearly')),
              _choice('Monthly', selected: frequency == 'Monthly', onTap: () => setState(() => frequency = 'Monthly')),
              _choice('Weekly', selected: frequency == 'Weekly', onTap: () => setState(() => frequency = 'Weekly')),
              _choice('Daily', selected: frequency == 'Daily', onTap: () => setState(() => frequency = 'Daily')),
            ]),
            const SizedBox(height: 24),
            _buildSectionTitle('Price range'),
            const SizedBox(height: 8),
            const Text('₹0 - ₹10000'),
            RangeSlider(
              min: 0,
              max: 10000,
              divisions: 100,
              labels: RangeLabels('₹${price.start.round()}', '₹${price.end.round()}'),
              activeColor: Colors.amber[700],
              values: price,
              onChanged: (v) => setState(() => price = v),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  final selectedCat = propertyType;
                  Navigator.push(context, MaterialPageRoute(builder: (_) => PropertyListPage(cityName: 'Nearby', category: selectedCat)));
                },
                style: ElevatedButton.styleFrom(padding: const EdgeInsets.symmetric(vertical: 16), backgroundColor: Colors.amber[600], foregroundColor: Colors.black),
                child: const Text("Let's Search"),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: Colors.black,
      ),
    );
  }

  Widget _buildOptionRow(List<String> options, String? selectedValue, Function(String) onChanged) {
    return Row(
      children: options.map((option) {
        final isSelected = selectedValue == option;
        return Expanded(
          child: Padding(
            padding: const EdgeInsets.only(right: 8),
            child: OutlinedButton(
              onPressed: () => onChanged(option),
              style: OutlinedButton.styleFrom(
                backgroundColor: isSelected ? Colors.yellow[100] : Colors.grey[100],
                foregroundColor: isSelected ? Colors.black : Colors.grey[600],
                side: BorderSide(
                  color: isSelected ? Colors.yellow[600]! : Colors.grey[300]!,
                ),
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                option,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildPriceField(String hint, String value, Function(String) onChanged) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[500]),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(horizontal: 12),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}

class _IconLabel extends StatelessWidget {
  final IconData icon; final String label; const _IconLabel({required this.icon, required this.label});
  @override
  Widget build(BuildContext context) {
    return Column(children: [Icon(icon, color: Colors.grey[700]), const SizedBox(height: 8), Text(label, style: TextStyle(color: Colors.grey[700]))]);
  }
}

class _QuickType extends StatelessWidget {
  final IconData icon; final String label; final VoidCallback onTap; const _QuickType({required this.icon, required this.label, required this.onTap});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Column(children: [Icon(icon, color: Colors.grey[800]), const SizedBox(height: 8), Text(label, style: const TextStyle(fontWeight: FontWeight.w600))]),
    );
  }
}

Widget _seg(String text, bool selected, VoidCallback onTap) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: selected ? Colors.amber[200] : Colors.grey[200],
        borderRadius: BorderRadius.circular(12),
      ),
      alignment: Alignment.center,
      child: Text(text, style: TextStyle(fontWeight: FontWeight.w600, color: Colors.black)),
    ),
  );
}

Widget _choice(String text, {bool selected = false, VoidCallback? onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: selected ? Colors.amber[100] : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: selected ? Colors.amber[600]! : Colors.grey[300]!),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 4, spreadRadius: 1)],
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        if (selected) Icon(Icons.check_circle, color: Colors.amber[700], size: 16),
        if (selected) const SizedBox(width: 6),
        Text(text),
      ]),
    ),
  );
}

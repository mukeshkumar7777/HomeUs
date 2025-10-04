import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  const FilterScreen({super.key});

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  String transactionType = 'Rent';
  String categoryType = 'Residential';
  String rentalFrequency = 'Monthly';
  String? selectedPropertyType;
  RangeValues priceRange = const RangeValues(0, 10000);

  final residentialTypes = ['Apartment', 'Townhouse', 'Penthouse', 'Village'];
  final commercialTypes = ['Corporate', 'Office', 'Shop', 'Building'];

  final propertyIcons = {
    'Apartment': Icons.apartment,
    'Townhouse': Icons.house_siding,
    'Penthouse': Icons.location_city,
    'Village': Icons.home,
    'Corporate': Icons.business,
    'Office': Icons.meeting_room,
    'Shop': Icons.store,
    'Building': Icons.domain,
  };

  Widget buildToggle(List<String> items, String current, Function(String) onTap) {
    final theme = Theme.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: items.map((item) {
          final isSelected = current == item;
          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(item),
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 12),
                decoration: BoxDecoration(
                  color: isSelected ? theme.colorScheme.primary : Colors.transparent,
                  borderRadius: BorderRadius.circular(10),
                ),
                alignment: Alignment.center,
                child: Text(
                  item,
                  style: TextStyle(
                    color: isSelected
                        ? theme.colorScheme.onPrimary
                        : theme.colorScheme.onSurface,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final propertyTypes =
        categoryType == 'Residential' ? residentialTypes : commercialTypes;

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        title: const Text("Filter"),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                transactionType = 'Rent';
                categoryType = 'Residential';
                rentalFrequency = 'Monthly';
                selectedPropertyType = null;
                priceRange = const RangeValues(0, 10000);
              });
            },
            child: Text(
              "Reset",
              style: TextStyle(
                color: Theme.of(context).colorScheme.onPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Buy / Rent Toggle
                buildToggle(['Buy', 'Rent'], transactionType,
                    (val) => setState(() => transactionType = val)),
                const SizedBox(height: 20),

                // Residential / Commercial
                const Text("Property types",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                buildToggle(['Residential', 'Commercial'], categoryType, (val) {
                  setState(() {
                    categoryType = val;
                    selectedPropertyType = null;
                  });
                }),
                const SizedBox(height: 20),

                // Property Type icons
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 400),
                  transitionBuilder: (child, animation) {
                    final fade = FadeTransition(opacity: animation, child: child);
                    final slide = SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.1, 0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: fade,
                    );
                    return slide;
                  },
                  child: SingleChildScrollView(
                    key: ValueKey(categoryType),
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: propertyTypes.map((type) {
                        final isSelected = selectedPropertyType == type;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedPropertyType =
                                  isSelected ? null : type;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 12),
                            child: Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context).colorScheme.surface,
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: Icon(
                                    propertyIcons[type],
                                    size: 28,
                                    color: isSelected
                                        ? Theme.of(context).colorScheme.onPrimary
                                        : Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(type,
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurface
                                            .withOpacity(0.6))),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Rental Frequency
                const Text("Rental frequency",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Wrap(
                  spacing: 10,
                  children: ['Yearly', 'Monthly', 'Weekly', 'Daily'].map((freq) {
                    return ChoiceChip(
                      label: Text(freq),
                      selected: rentalFrequency == freq,
                      onSelected: (_) =>
                          setState(() => rentalFrequency = freq),
                      selectedColor: Theme.of(context).colorScheme.primary,
                      backgroundColor: Theme.of(context).colorScheme.surface,
                      labelStyle: TextStyle(
                        color: rentalFrequency == freq
                            ? Theme.of(context).colorScheme.onPrimary
                            : Theme.of(context).colorScheme.onSurface,
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 20),

                // Price Range
                const Text("Price range",
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
                const SizedBox(height: 10),
                Text(
                    "\$${priceRange.start.toInt()} - \$${priceRange.end.toInt()}"),
                RangeSlider(
                  values: priceRange,
                  min: 0,
                  max: transactionType == 'Rent' ? 15000 : 5000000,
                  divisions: 50,
                  labels: RangeLabels(
                    '\$${priceRange.start.toInt()}',
                    '\$${priceRange.end.toInt()}',
                  ),
                  activeColor: Theme.of(context).colorScheme.primary,
                  onChanged: (values) =>
                      setState(() => priceRange = values),
                ),
              ],
            ),
          ),

          // Bottom Button
          SafeArea(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, {
                    'transactionType': transactionType,
                    'categoryType': categoryType,
                    'rentalFrequency': rentalFrequency,
                    'selectedPropertyType': selectedPropertyType,
                    'minPrice': priceRange.start.toInt(),
                    'maxPrice': priceRange.end.toInt(),
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text("Let's Search",
                    style: TextStyle(fontSize: 16, color: Colors.white)),
              ),
            ),
          )
        ],
      ),
    );
  }
}

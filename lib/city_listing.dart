

import 'package:flutter/material.dart';
import 'property_details.dart';
import 'property_model.dart';
// ...existing code...
// (Optional wishlist/share removed for now)
// Using local mock city data below

class CityProperty {
  final String title;
  final String ownerName;
  final String imageAsset; // path in assets/
  final String roomType;
  final String addressLine;
  final String phoneMasked;
  final String price;
  final String offer;

  const CityProperty({
    required this.title,
    required this.ownerName,
    required this.imageAsset,
    required this.roomType,
    required this.addressLine,
    required this.phoneMasked,
    required this.price,
    required this.offer,
  });
}

// Mock data per city using ASSET images
final Map<String, List<CityProperty>> cityToProperties = {
  "Kakinada": [
    CityProperty(
      title: "3BHK Home",
      ownerName: "Sasi kumar",
      imageAsset: "assets/house2.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in T Nagar",
      phoneMasked: "1234567xxx",
      price: "\$122",
      offer: "Upto 7% offer",
    ),
    CityProperty(
      title: "3B2H2K Home",
      ownerName: "Selvam",
      imageAsset: "assets/house3.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in T Nagar",
      phoneMasked: "1234567xxx",
      price: "\$149",
      offer: "Upto 7% offer",
    ),
    CityProperty(
      title: "2BHK Apartment",
      ownerName: "Rajesh",
      imageAsset: "assets/2bhk.jpg",
      roomType: "Apartment",
      addressLine: "Main Rd, Kakinada",
      phoneMasked: "98xxxxxx12",
      price: "₹12000",
      offer: "No brokerage",
    ),
    CityProperty(
      title: "PG near Main Rd",
      ownerName: "Priya",
      imageAsset: "assets/pg2.jpg",
      roomType: "PG",
      addressLine: "Near Bus Stand",
      phoneMasked: "97xxxxxx90",
      price: "₹7000",
      offer: "Meals included",
    ),
    CityProperty(
      title: "Family 3BHK",
      ownerName: "Rakesh",
      imageAsset: "assets/house3.jpg",
      roomType: "House",
      addressLine: "Suburb Colony",
      phoneMasked: "93xxxxxx22",
      price: "₹18000",
      offer: "Corner plot",
    ),
    CityProperty(
      title: "Student Hostel",
      ownerName: "Anand",
      imageAsset: "assets/hostel1.jpg",
      roomType: "PG",
      addressLine: "College Road",
      phoneMasked: "99xxxxxx14",
      price: "₹6500",
      offer: "Boys/Girls",
    ),
    CityProperty(
      title: "Modern 2BHK",
      ownerName: "Hari",
      imageAsset: "assets/house4.jpg",
      roomType: "Apartment",
      addressLine: "IT Park Road",
      phoneMasked: "98xxxxxx71",
      price: "₹13500",
      offer: "Semi-furnished",
    ),
    CityProperty(
      title: "Corner Villa",
      ownerName: "Sowmya",
      imageAsset: "assets/house7.jpg",
      roomType: "Villa",
      addressLine: "Lake View Colony",
      phoneMasked: "97xxxxxx44",
      price: "₹26000",
      offer: "Garden + Parking",
    ),
    CityProperty(
      title: "Compact Studio",
      ownerName: "Arun",
      imageAsset: "assets/house5.jpg",
      roomType: "Studio",
      addressLine: "Station Road",
      phoneMasked: "95xxxxxx20",
      price: "₹8000",
      offer: "Near metro",
    ),
    CityProperty(
      title: "Shared PG",
      ownerName: "Rithika",
      imageAsset: "assets/pgs.jpg",
      roomType: "PG",
      addressLine: "Old Town",
      phoneMasked: "94xxxxxx36",
      price: "₹6000",
      offer: "AC Rooms",
    ),
  ],
  "Ramesam Peta": [
    CityProperty(
      title: "2BHK Premium",
      ownerName: "Sanjay",
      imageAsset: "assets/house4.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in Anna Nagar",
      phoneMasked: "9876567xxx",
      price: "\$130",
      offer: "Flat 5% off",
    ),
    CityProperty(
      title: "Villa Annex",
      ownerName: "Karthik",
      imageAsset: "assets/house5.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in Anna Nagar",
      phoneMasked: "9876567xxx",
      price: "\$199",
      offer: "Upto 10% offer",
    ),
    CityProperty(
      title: "Studio Cozy",
      ownerName: "Harsha",
      imageAsset: "assets/house5.jpg",
      roomType: "Studio",
      addressLine: "Central Street",
      phoneMasked: "98xxxxxx21",
      price: "₹9000",
      offer: "Near market",
    ),
    CityProperty(
      title: "Family Home",
      ownerName: "Lakshmi",
      imageAsset: "assets/house7.jpg",
      roomType: "House",
      addressLine: "Green Layout",
      phoneMasked: "96xxxxxx32",
      price: "₹15000",
      offer: "Newly painted",
    ),
    CityProperty(
      title: "Bright 2BHK",
      ownerName: "Ajay",
      imageAsset: "assets/2bhk.jpg",
      roomType: "Apartment",
      addressLine: "Park Street",
      phoneMasked: "93xxxxxx73",
      price: "₹12500",
      offer: "Near school",
    ),
    CityProperty(
      title: "Economy PG",
      ownerName: "Kiran",
      imageAsset: "assets/pg2.jpg",
      roomType: "PG",
      addressLine: "Market Lane",
      phoneMasked: "92xxxxxx88",
      price: "₹5500",
      offer: "Meals extra",
    ),
    CityProperty(
      title: "1BHK Starter",
      ownerName: "Swathi",
      imageAsset: "assets/house5.jpg",
      roomType: "Apartment",
      addressLine: "Bypass Road",
      phoneMasked: "90xxxxxx77",
      price: "₹9000",
      offer: "Lift",
    ),
    CityProperty(
      title: "Independent House",
      ownerName: "Sreedhar",
      imageAsset: "assets/house3.jpg",
      roomType: "House",
      addressLine: "Teachers Colony",
      phoneMasked: "98xxxxxx01",
      price: "₹17000",
      offer: "Car parking",
    ),
    CityProperty(
      title: "Girls Hostel",
      ownerName: "Neha",
      imageAsset: "assets/hostel1.jpg",
      roomType: "PG",
      addressLine: "Temple Road",
      phoneMasked: "97xxxxxx09",
      price: "₹6200",
      offer: "Safe area",
    ),
  ],
  "Vizag": [
    CityProperty(
      title: "2BHK Premium",
      ownerName: "Sanjay",
      imageAsset: "assets/house6.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in Anna Nagar",
      phoneMasked: "9876567xxx",
      price: "\$130",
      offer: "Flat 5% off",
    ),
    CityProperty(
      title: "Villa Annex",
      ownerName: "Karthik",
      imageAsset: "assets/pgs.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in Anna Nagar",
      phoneMasked: "9876567xxx",
      price: "\$199",
      offer: "Upto 10% offer",
    ),
    CityProperty(
      title: "Sea View 2BHK",
      ownerName: "Suman",
      imageAsset: "assets/house6.jpg",
      roomType: "Apartment",
      addressLine: "RK Beach Rd",
      phoneMasked: "93xxxxxx45",
      price: "₹15500",
      offer: "Beach nearby",
    ),
    CityProperty(
      title: "Hostel RK Road",
      ownerName: "Anitha",
      imageAsset: "assets/hostel1.jpg",
      roomType: "PG",
      addressLine: "RK Road",
      phoneMasked: "95xxxxxx11",
      price: "₹6500",
      offer: "Girls/Unisex",
    ),
    CityProperty(
      title: "Luxury Villa",
      ownerName: "Meera",
      imageAsset: "assets/house7.jpg",
      roomType: "Villa",
      addressLine: "Seaside Layout",
      phoneMasked: "92xxxxxx33",
      price: "₹28000",
      offer: "Garden + Parking",
    ),
    CityProperty(
      title: "Corporate PG",
      ownerName: "Varun",
      imageAsset: "assets/pgs.jpg",
      roomType: "PG",
      addressLine: "Dwaraka Nagar",
      phoneMasked: "96xxxxxx18",
      price: "₹8500",
      offer: "AC + WiFi",
    ),
    CityProperty(
      title: "3BHK Prime",
      ownerName: "Rohit",
      imageAsset: "assets/house2.jpg",
      roomType: "Apartment",
      addressLine: "Railway New Colony",
      phoneMasked: "95xxxxxx61",
      price: "₹22000",
      offer: "Gated community",
    ),
    CityProperty(
      title: "Studio Bay",
      ownerName: "Isha",
      imageAsset: "assets/house5.jpg",
      roomType: "Studio",
      addressLine: "Beach Road",
      phoneMasked: "94xxxxxx28",
      price: "₹9500",
      offer: "Sea breeze",
    ),
    CityProperty(
      title: "Budget 1BHK",
      ownerName: "Nitin",
      imageAsset: "assets/house4.jpg",
      roomType: "Apartment",
      addressLine: "Gajuwaka",
      phoneMasked: "93xxxxxx07",
      price: "₹10500",
      offer: "New flooring",
    ),
  ],
  "Rajamundry": [
    CityProperty(
      title: "2BHK Premium",
      ownerName: "Sanjay",
      imageAsset: "assets/house 1.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in Anna Nagar",
      phoneMasked: "9876567xxx",
      price: "\$130",
      offer: "Flat 5% off",
    ),
    CityProperty(
      title: "Villa Annex",
      ownerName: "Kowshik",
      imageAsset: "assets/hostel1.jpg",
      roomType: "owner",
      addressLine: "UNISEX's in Anna Nagar",
      phoneMasked: "9876567xxx",
      price: "\$199",
      offer: "Upto 10% offer",
    ),
    CityProperty(
      title: "River View Home",
      ownerName: "Karthik",
      imageAsset: "assets/house3.jpg",
      roomType: "House",
      addressLine: "Near Godavari",
      phoneMasked: "97xxxxxx65",
      price: "₹14000",
      offer: "Scenic view",
    ),
    CityProperty(
      title: "Budget PG",
      ownerName: "Rakesh",
      imageAsset: "assets/pg2.jpg",
      roomType: "PG",
      addressLine: "Temple Street",
      phoneMasked: "98xxxxxx77",
      price: "₹5500",
      offer: "WiFi Free",
    ),
    CityProperty(
      title: "Compact 1BHK",
      ownerName: "Divya",
      imageAsset: "assets/house5.jpg",
      roomType: "Apartment",
      addressLine: "Market Road",
      phoneMasked: "90xxxxxx55",
      price: "₹10000",
      offer: "Lift + Backup",
    ),
    CityProperty(
      title: "City PG",
      ownerName: "Mahesh",
      imageAsset: "assets/pgs.jpg",
      roomType: "PG",
      addressLine: "City Center",
      phoneMasked: "99xxxxxx12",
      price: "₹6000",
      offer: "Near bus stop",
    ),
    CityProperty(
      title: "2BHK Green",
      ownerName: "Sunitha",
      imageAsset: "assets/house2.jpg",
      roomType: "Apartment",
      addressLine: "Green Park",
      phoneMasked: "98xxxxxx64",
      price: "₹13000",
      offer: "Park facing",
    ),
    CityProperty(
      title: "Modern Villa",
      ownerName: "Vikas",
      imageAsset: "assets/house7.jpg",
      roomType: "Villa",
      addressLine: "Canal Road",
      phoneMasked: "97xxxxxx41",
      price: "₹30000",
      offer: "Private lawn",
    ),
    CityProperty(
      title: "Student Rooms",
      ownerName: "Gayathri",
      imageAsset: "assets/hostel1.jpg",
      roomType: "PG",
      addressLine: "College Area",
      phoneMasked: "96xxxxxx31",
      price: "₹5800",
      offer: "Shared kitchen",
    ),
  ],
};

class CityListingsPage extends StatefulWidget {
  final String cityName;
  const CityListingsPage({super.key, required this.cityName});

  @override
  State<CityListingsPage> createState() => _CityListingsPageState();
}

class _FilterSheet extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  const _FilterSheet({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    final List<String> options = ['All', 'Apartment', 'House', 'Villa', 'PG', 'Studio'];
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options
            .map((o) => ListTile(
                  leading: Icon(selected == o ? Icons.radio_button_checked : Icons.radio_button_off),
                  title: Text(o),
                  onTap: () => onSelect(o),
                ))
            .toList(),
      ),
    );
  }
}

class _SortSheet extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  const _SortSheet({required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(selected == 'price_low' ? Icons.check : null),
            title: const Text('Price: Low to High'),
            onTap: () => onSelect('price_low'),
          ),
          ListTile(
            leading: Icon(selected == 'price_high' ? Icons.check : null),
            title: const Text('Price: High to Low'),
            onTap: () => onSelect('price_high'),
          ),
          ListTile(
            leading: Icon(selected == 'none' ? Icons.check : null),
            title: const Text('Default'),
            onTap: () => onSelect('none'),
          ),
          const SizedBox(height: 12),
        ],
      ),
    );
  }
}

class _CityListingsPageState extends State<CityListingsPage> {
  late List<CityProperty> _all;
  late List<CityProperty> _shown;
  String _sort = 'none';
  String _filterType = 'All';

  @override
  void initState() {
    super.initState();
    _all = List.of(cityToProperties[widget.cityName] ?? const <CityProperty>[]);
    _shown = List.of(_all);
  }

  void _applySort(String mode) {
    setState(() {
      _sort = mode;
      _shown = List.of(_shown);
      if (mode == 'price_low') {
        _shown.sort((a, b) => _price(a).compareTo(_price(b)));
      } else if (mode == 'price_high') {
        _shown.sort((a, b) => _price(b).compareTo(_price(a)));
      }
    });
  }

  int _price(CityProperty p) {
    final s = p.price.replaceAll(RegExp('[^0-9]'), '');
    return int.tryParse(s) ?? 0;
  }

  void _applyFilter(String type) {
    setState(() {
      _filterType = type;
      if (type == 'All') {
        _shown = List.of(_all);
      } else {
        _shown = _all.where((e) => e.roomType.toLowerCase() == type.toLowerCase()).toList();
      }
      if (_sort != 'none') _applySort(_sort);
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<CityProperty> items = _shown;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xFFF7C948),
        title: Text(widget.cityName, style: const TextStyle(fontWeight: FontWeight.w700)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new),
          onPressed: () => Navigator.pop(context),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Total ${items.length} properties",
                style: const TextStyle(fontSize: 14, color: Colors.black54)),
            const SizedBox(height: 12),
            Expanded(
              child: ListView.separated(
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 14),
                itemBuilder: (context, index) {
                  final p = items[index];
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return ConstrainedBox(
                        constraints: const BoxConstraints(minHeight: 96),
                        child: _PropertyListTile(property: p, cityName: widget.cityName),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 6, 16, 10),
          child: Row(
            children: [
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.black,
                      side: const BorderSide(color: Colors.amber),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => _FilterSheet(
                          selected: _filterType,
                          onSelect: (v) { Navigator.pop(context); _applyFilter(v); },
                        ),
                      );
                    },
                    child: const Text("Filter", style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 48,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFF7C948),
                      foregroundColor: Colors.black,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      elevation: 0,
                    ),
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        builder: (_) => _SortSheet(
                          selected: _sort,
                          onSelect: (v) { Navigator.pop(context); _applySort(v); },
                        ),
                      );
                    },
                    child: const Text("Sort By", style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PropertyListTile extends StatelessWidget {
  final CityProperty property;
  final String cityName;
  const _PropertyListTile({required this.property, required this.cityName});

  @override
  Widget build(BuildContext context) {
    // Convert CityProperty to Property for wishlist
    final prop = Property(
      id: property.title + cityName,
      imageAsset: property.imageAsset,
      title: property.title,
      location: cityName,
      price: property.price,
      description: property.addressLine,
      amenities: const [],
      contactInfo: property.phoneMasked,
      propertyType: property.roomType,
      bedrooms: 0,
      bathrooms: 0,
      area: 0,
      isAvailable: true,
      images: const [],
    );
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => PropertyDetailsScreen(
              property: prop,
              imageAsset: property.imageAsset,
              title: property.title,
              location: cityName,
              price: property.price,
              description: property.addressLine,
            ),
          ),
        );
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.06), blurRadius: 10, offset: const Offset(0, 4))],
          border: Border.all(color: Colors.black12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                property.imageAsset,
                width: 120,
                height: 96,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    property.title,
                    style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black12, borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(property.roomType, style: const TextStyle(fontSize: 11)),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: Colors.black12, borderRadius: BorderRadius.circular(999),
                        ),
                        child: Text(
                          property.ownerName,
                          style: const TextStyle(fontSize: 11),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(property.addressLine, style: const TextStyle(fontSize: 12, color: Colors.black54), maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(property.phoneMasked, style: const TextStyle(fontSize: 12, color: Colors.black54), maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 88,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Text("Start at", style: TextStyle(fontSize: 10, color: Colors.black45)),
                Text(property.price, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800)),
                const SizedBox(height: 8),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(color: Colors.black12, borderRadius: BorderRadius.circular(999)),
                  child: Text(
                    property.offer,
                    style: const TextStyle(fontSize: 11),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            )
          ],
        ),
      ),
    );
  }
}
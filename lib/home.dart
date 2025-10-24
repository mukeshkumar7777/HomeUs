
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'search_screen.dart';
import 'package:homeus/propertycard.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'city_listing.dart';
import 'property_model.dart';
import 'responsive.dart';
import 'wishlist_screen.dart';
import 'notification_page.dart';
import 'settings_screen.dart';
import 'help_screen.dart';
import 'about_screen.dart';

class HomeDashboard extends StatefulWidget {
  const HomeDashboard({super.key});

  @override
  State<HomeDashboard> createState() => _HomeDashboardState();
}

class _HomeDashboardState extends State<HomeDashboard> {
  final TextEditingController _searchCtrl = TextEditingController();
  final FocusNode _searchFocus = FocusNode();
  String _query = '';

  @override
  void initState() {
    super.initState();
    _searchCtrl.addListener(() => setState(() => _query = _searchCtrl.text.trim()));
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    _searchFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    // Asset images for the carousel
    final List<String> bannerAssets = [
      'assets/house6.jpg',
      'assets/pgs.jpg',
      'assets/hostel1.jpg',
    ];

    final double carouselHeight = Responsive.value<double>(
      context: context,
      mobile: 180,
      tablet: 240,
      desktop: 300,
    );

    final int gridColumns = Responsive.value<int>(
      context: context,
      mobile: 2,
      tablet: 3,
      desktop: 4,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text("HomeUs"),
        actions: [
          const SizedBox(width: 10),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const NotificationPage()),
              );
            },
            icon: const Icon(Icons.notifications),
            tooltip: 'Notifications',
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const WishlistScreen()),
              );
            },
            icon: const Icon(Icons.favorite_border),
            tooltip: 'Wishlist',
          ),
          const SizedBox(width: 12),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFFFFF8E1), // light amber, similar to home
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(
                color: Color(0xFFF7C948),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(24),
                  bottomRight: Radius.circular(24),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage('assets/default_account.jpg'),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Welcome, ${user?.displayName ?? 'User'}!",
                    style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings, color: Colors.black87),
              title: const Text('Settings', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.help_outline, color: Colors.black87),
              title: const Text('Help & Support', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const HelpScreen()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Colors.black87),
              title: const Text('About', style: TextStyle(fontWeight: FontWeight.w600)),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context, MaterialPageRoute(builder: (_) => const AboutScreen()));
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _searchCtrl,
                          focusNode: _searchFocus,
                          decoration: InputDecoration(
                            hintText: "Search city or location...",
                            prefixIcon: const Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                          ),
                          onSubmitted: _handleSearchSubmit,
                        ),
                      ),
                      const SizedBox(width: 10),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SearchScreen(),
                            ),
                          );
                        },
                          child: Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.25),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(Icons.filter_list, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                  if (_query.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    _buildSearchSuggestions(_query),
                  ]
                ],
              ),
            ),

            // Promo slider from assets
            CarouselSlider(
              options: CarouselOptions(
                height: carouselHeight,
                autoPlay: true,
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                autoPlayInterval: const Duration(seconds: 3),
              ),
              items: bannerAssets.map((path) => PromoCard(imageAsset: path)).toList(),
            ),

            const SizedBox(height: 8),

            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Text(
                "Near by",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _nearbyAreas.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: gridColumns,
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.1,
                ),
                itemBuilder: (context, index) {
                  final area = _nearbyAreas[index];
                  return NearbyAreaCard(imageAsset: area.imageAsset, name: area.name);
                },
              ),
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Recommended Properties",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text("see all"),
                  ),
                ],
              ),
            ),

            PropertyCard(
              property: Property.sampleProperties[0],
              imageAsset: Property.sampleProperties[0].imageAsset,
              title: Property.sampleProperties[0].title,
              location: Property.sampleProperties[0].location,
              price: Property.sampleProperties[0].price,
            ),
            PropertyCard(
              property: Property.sampleProperties[1],
              imageAsset: Property.sampleProperties[1].imageAsset,
              title: Property.sampleProperties[1].title,
              location: Property.sampleProperties[1].location,
              price: Property.sampleProperties[1].price,
            ),

            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}

// ---- Nearby helpers ----

class NearbyArea {
  final String name;
  final String imageAsset; // asset path
  const NearbyArea({required this.name, required this.imageAsset});
}

const List<NearbyArea> _nearbyAreas = [
  NearbyArea(
    name: "Kakinada",
    imageAsset: "assets/kakinada.jpg",
  ),
   NearbyArea(
    name: "Rajamundry",
    imageAsset: "assets/rajamundry.jpeg",
  ),
  NearbyArea(
    name: "Vizag",
    imageAsset: "assets/vizag.jpeg",
  ),
 
  NearbyArea(
    name: "Ramesam Peta",
    imageAsset: "assets/house2.jpg",
  ),
];

class NearbyAreaCard extends StatelessWidget {
  final String imageAsset;
  final String name;

  const NearbyAreaCard({super.key, required this.imageAsset, required this.name});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (_) => CityListingsPage(cityName: name)),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 10,
                child: Image.asset(imageAsset, fit: BoxFit.cover),
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Text(
                name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
void _handleSearchSubmit(String value) {
  // No-op placeholder; suggestions handle navigation on tap.
}

// ---- Search Suggestions ----
Widget _buildSearchSuggestions(String query) {
  final lower = query.toLowerCase();
  final cities = _nearbyAreas.map((a) => a.name).where((n) => n.toLowerCase().contains(lower)).toList();
  if (cities.isEmpty) return const SizedBox.shrink();
  return Container(
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(12),
      boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 3))],
      border: Border.all(color: Colors.black12),
    ),
    child: ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cities.length,
      separatorBuilder: (_, __) => const Divider(height: 1),
      itemBuilder: (context, i) {
        final name = cities[i];
        return ListTile(
          leading: const Icon(Icons.location_on, color: Colors.amber),
          title: Text(name),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (_) => CityListingsPage(cityName: name)));
          },
        );
      },
    ),
  );
}

// ---- Promo Card ----2
class PromoCard extends StatelessWidget {
  final String imageAsset;
  const PromoCard({super.key, required this.imageAsset});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.06), blurRadius: 8, offset: const Offset(0, 3))],
      ),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Image.asset(imageAsset, fit: BoxFit.cover, width: double.infinity),
          ),
          Positioned(
            left: 12,
            top: 12,
            right: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Looking For Tenants\nBuyers?",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.w800, fontSize: 18, shadows: [
                    Shadow(color: Colors.black54, blurRadius: 6, offset: Offset(0, 1)),
                  ]),
                ),
                SizedBox(height: 6),
                Text(
                  "Faster & Verified Tenants/Buyers\nPay ZERO brokerage",
                  style: TextStyle(color: Colors.white, fontSize: 12, height: 1.2, shadows: [
                    Shadow(color: Colors.black38, blurRadius: 6, offset: Offset(0, 1)),
                  ]),
                ),
              ],
            ),
          ),
          Positioned(
            left: 12,
            bottom: 12,
            child: ElevatedButton(
              onPressed: () {},
              child: const Text("Post FREE Property Ad"),
            ),
          )
        ],
      ),
    );
  }
}
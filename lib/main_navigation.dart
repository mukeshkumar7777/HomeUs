import 'package:flutter/material.dart';
import 'home.dart';
import 'search_screen.dart';
import 'owners_screen.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';

class MainNavigation extends StatefulWidget {
  const MainNavigation({super.key});

  @override
  State<MainNavigation> createState() => _MainNavigationState();
}

class _MainNavigationState extends State<MainNavigation> with SingleTickerProviderStateMixin {
  int _currentIndex = 0; // Ensure starts on Home page
  late AnimationController _navController;
  late Animation<double> _indicatorAnim;

  final List<Widget> _screens = [
    const HomeDashboard(), // Home
    const SearchScreen(), // Search
    const OwnersScreen(), // Owner/Properties
    const ChatScreen(), // Chat
    const ProfileScreen(), // Profile
  ];

  @override
  void initState() {
    super.initState();
    _currentIndex = 0; // Force start on Home page
    _navController = AnimationController(vsync: this, duration: const Duration(milliseconds: 350));
    _indicatorAnim = CurvedAnimation(parent: _navController, curve: Curves.easeOutCubic);
    _navController.forward();
  }

  @override
  void dispose() {
    _navController.dispose();
    super.dispose();
  }

  Widget _buildCustomBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
        child: Container(
          height: 80,
          color: Colors.white,
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(5, (index) {
                  final bool isSelected = index == _currentIndex;
                  return Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _currentIndex = index),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Transform.scale(
                              scale: isSelected ? 1.1 : 1.0,
                              child: Icon(
                                [Icons.home, Icons.search, Icons.business, Icons.chat, Icons.person][index],
                                color: isSelected ? Colors.amber.shade700 : Colors.grey,
                                size: 26,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              ['Home', 'Search', 'Owner', 'Chat', 'Profile'][index],
                              style: TextStyle(
                                color: isSelected ? Colors.amber.shade700 : Colors.grey,
                                fontSize: 11,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
              Positioned(
                left: 0,
                bottom: 0,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  width: MediaQuery.of(context).size.width / 5,
                  height: 3,
                  decoration: BoxDecoration(
                    color: Colors.amber.shade700,
                    borderRadius: BorderRadius.circular(1.5),
                  ),
                  transform: Matrix4.translationValues(
                    _currentIndex * (MediaQuery.of(context).size.width / 5),
                    0,
                    0,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: _buildCustomBottomNav(),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  _NavItem({required this.icon, required this.label});
}

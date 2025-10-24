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

class _MainNavigationState extends State<MainNavigation>
    with SingleTickerProviderStateMixin {
  int _currentIndex = 0;
  late AnimationController _controller;

  final List<Widget> _screens = [
    const HomeDashboard(),
    const SearchScreen(),
    const OwnersScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  final navItems = const [
    {'icon': Icons.home, 'label': 'Home'},
    {'icon': Icons.search, 'label': 'Search'},
    {'icon': Icons.business, 'label': 'Owner'},
    {'icon': Icons.chat, 'label': 'Chat'},
    {'icon': Icons.person, 'label': 'Profile'},
  ];

  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: const Duration(milliseconds: 400));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onItemTapped(int index) {
    setState(() => _currentIndex = index);
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final selectedColor = const Color(0xFFF7C948);
    final unselectedColor = Colors.black;

    return Scaffold(
      backgroundColor: Colors.white,
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 100),
        transitionBuilder: (child, animation) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position:
                Tween<Offset>(begin: const Offset(0.05, 0), end: Offset.zero)
                    .animate(animation),
            child: child,
          ),
        ),
        child: _screens[_currentIndex],
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: Container(
            height: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(navItems.length, (i) {
                final selected = i == _currentIndex;
                return GestureDetector(
                  onTap: () => _onItemTapped(i),
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 100),
                    scale: selected ? 1.15 : 1.0,
                    curve: Curves.easeOut,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 100),
                          curve: Curves.easeOut,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: selected ? selectedColor : Colors.transparent,
                            shape: BoxShape.circle,
                            boxShadow: selected
                                ? [
                                    BoxShadow(
                                      color: selectedColor.withOpacity(0.3),
                                      blurRadius: 10,
                                      spreadRadius: 1,
                                    ),
                                  ]
                                : [],
                          ),
                          child: Icon(
                            navItems[i]['icon'] as IconData,
                            color: selected ? Colors.white : unselectedColor,
                            size: 24,
                          ),
                        ),
                        const SizedBox(height: 5),
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 100),
                          style: TextStyle(
                            fontSize: selected ? 12 : 11,
                            fontWeight:
                                selected ? FontWeight.bold : FontWeight.w500,
                            color: selected ? selectedColor : unselectedColor,
                          ),
                          child: Text(navItems[i]['label']! as String),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Color drawerColor = Colors.blue.shade700;
    final Color iconColor = Colors.white;
    final Color tileColor = Colors.blue.shade100;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: drawerColor,
      ),
      // Drawer removed as requested
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          NotificationTile(
            icon: Icons.home,
            title: 'New Property Added',
            subtitle: 'A new 2BHK flat is now available in Kakinada.',
            time: 'Just now',
          ),
          NotificationTile(
            icon: Icons.favorite,
            title: 'Wishlist Update',
            subtitle: 'A property in your wishlist has a price drop!',
            time: '10 min ago',
          ),
          NotificationTile(
            icon: Icons.notifications_active,
            title: 'Reminder',
            subtitle: 'Don\'t forget to check out new listings in Vizag.',
            time: '1 hr ago',
          ),
          NotificationTile(
            icon: Icons.local_offer,
            title: 'Special Offer',
            subtitle: 'Get 10% off on your first booking.',
            time: '2 hrs ago',
          ),
        ],
      ),
    );
  }
}

// Settings Page
class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: const Color(0xFF29A1F7),
      ),
      body: const Center(
        child: Text('Settings page content goes here.'),
      ),
    );
  }
}

// Help & Support Page
class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: const Color(0xFF29A1F7),
      ),
      body: const Center(
        child: Text('Help & Support content goes here.'),
      ),
    );
  }
}

class NotificationTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const NotificationTile({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      child: ListTile(
        leading: Icon(icon, color: Colors.amber, size: 32),
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(time, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ),
    );
  }
}

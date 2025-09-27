import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'edit_profile_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: _editProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Profile Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.blue.shade400, Colors.blue.shade600],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundImage: const NetworkImage('https://picsum.photos/200/200?random=user'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    user?.displayName ?? 'User',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    user?.email ?? 'email@example.com',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Premium Member',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Stats Cards
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: _buildStatCard('Properties Viewed', '24', Icons.visibility),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildStatCard('Bookings', '3', Icons.book_online),
                  ),
                ],
              ),
            ),

            // Menu Items
            _buildMenuSection('Account', [
              _buildMenuItem(
                icon: Icons.person_outline,
                title: 'Personal Information',
                subtitle: 'Update your personal details',
                onTap: () => _showPersonalInfo(),
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: 'Addresses',
                subtitle: 'Manage your saved addresses',
                onTap: () => _showAddresses(),
              ),
              _buildMenuItem(
                icon: Icons.notifications_outlined,
                title: 'Notifications',
                subtitle: 'Manage notification preferences',
                onTap: () => _showNotifications(),
              ),
            ]),

            _buildMenuSection('Preferences', [
              _buildMenuItem(
                icon: Icons.search_outlined,
                title: 'Search Preferences',
                subtitle: 'Customize your property search',
                onTap: () => _showSearchPreferences(),
              ),
              _buildMenuItem(
                icon: Icons.language_outlined,
                title: 'Language',
                subtitle: 'English',
                onTap: () => _showLanguageSettings(),
              ),
              _buildMenuItem(
                icon: Icons.dark_mode_outlined,
                title: 'Theme',
                subtitle: 'Light',
                onTap: () => _showThemeSettings(),
              ),
            ]),

            _buildMenuSection('Support', [
              _buildMenuItem(
                icon: Icons.help_outline,
                title: 'Help Center',
                subtitle: 'Get help and support',
                onTap: () => _showHelpCenter(),
              ),
              _buildMenuItem(
                icon: Icons.feedback_outlined,
                title: 'Feedback',
                subtitle: 'Share your feedback',
                onTap: () => _showFeedback(),
              ),
              _buildMenuItem(
                icon: Icons.info_outline,
                title: 'About',
                subtitle: 'App version 1.0.0',
                onTap: () => _showAbout(),
              ),
            ]),

            _buildMenuSection('Account Actions', [
              _buildMenuItem(
                icon: Icons.logout,
                title: 'Logout',
                subtitle: 'Sign out of your account',
                onTap: _logout,
                textColor: Colors.red,
              ),
            ]),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Icon(icon, color: Colors.blue, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              title,
              style: const TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
        ),
        Card(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(children: items),
        ),
      ],
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
    Color? textColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: textColor ?? Colors.blue),
      title: Text(
        title,
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: const Icon(Icons.arrow_forward_ios, size: 16),
      onTap: onTap,
    );
  }

  void _editProfile() {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditProfileScreen(
            currentName: user.displayName ?? 'User',
            currentEmail: user.email ?? 'email@example.com',
            onProfileUpdated: (newName, newEmail) {
              // Profile updates will be reflected in real-time via the stream
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
            },
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No user logged in')),
      );
    }
  }

  void _showPersonalInfo() {
    final user = FirebaseAuth.instance.currentUser;
    _showInfoDialog('Personal Information', [
      'Name: ${user?.displayName ?? 'User'}',
      'Email: ${user?.email ?? 'email@example.com'}',
      'Phone: +91 98765 43210',
      'Date of Birth: 15/03/1990',
      'Gender: Male',
    ]);
  }

  void _showAddresses() {
    _showInfoDialog('Saved Addresses', [
      'Home: 123 Main Street, Hyderabad',
      'Office: 456 Business Park, Bangalore',
      'Current: 789 Temporary Address, Mumbai',
    ]);
  }

  void _showNotifications() {
    _showInfoDialog('Notification Settings', [
      'Property Alerts: Enabled',
      'Booking Updates: Enabled',
      'Promotional: Disabled',
      'Email Notifications: Enabled',
    ]);
  }

  void _showSearchPreferences() {
    _showInfoDialog('Search Preferences', [
      'Preferred Locations: Hyderabad, Bangalore',
      'Budget Range: ₹10,000 - ₹25,000',
      'Property Type: Apartment, Villa',
      'Amenities: WiFi, Parking, Security',
    ]);
  }

  void _showLanguageSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Language'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('English'),
              trailing: const Icon(Icons.check, color: Colors.blue),
              onTap: () => Navigator.pop(context),
            ),
            const ListTile(
              title: Text('Hindi'),
            ),
            const ListTile(
              title: Text('Telugu'),
            ),
          ],
        ),
      ),
    );
  }

  void _showThemeSettings() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Theme'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              title: const Text('Light'),
              trailing: const Icon(Icons.check, color: Colors.blue),
              onTap: () => Navigator.pop(context),
            ),
            const ListTile(
              title: Text('Dark'),
            ),
            const ListTile(
              title: Text('System'),
            ),
          ],
        ),
      ),
    );
  }

  void _showHelpCenter() {
    _showInfoDialog('Help Center', [
      'Frequently Asked Questions',
      'Contact Support',
      'User Guide',
      'Video Tutorials',
    ]);
  }

  void _showFeedback() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Send Feedback'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Share your feedback...',
            border: OutlineInputBorder(),
          ),
          maxLines: 5,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Feedback sent successfully!')),
              );
            },
            child: const Text('Send'),
          ),
        ],
      ),
    );
  }

  void _showAbout() {
    _showInfoDialog('About HomeUs', [
      'Version: 1.0.0',
      'Build: 2024.01.15',
      'Developer: HomeUs Team',
      'Contact: support@homeus.com',
    ]);
  }

  void _showInfoDialog(String title, List<String> items) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(item),
          )).toList(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Close'),
          ),
        ],
      ),
    );
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Logged out successfully!')),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

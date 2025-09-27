import 'package:flutter/material.dart';
//import 'package:shared_preferences/shared_preferences.dart';

import '../localization.dart';
import 'edit_profile_screen.dart';
import 'notification_screen.dart';
import 'help_screen.dart';
import 'payment_screen.dart';
import 'saved_screen.dart';
import 'privacy_screen.dart';
import 'terms_conditions_screen.dart';

class SettingsScreen extends StatelessWidget {
  final String name;
  final String email;
  final bool isDarkMode;
  final String language;
  final bool paymentEnabled;
  final Function(bool) onThemeChanged;
  final Function(String, String) onProfileUpdated;
  final Function(String) onLanguageChanged;
  final Function(bool) onPaymentEnabledChanged;

  const SettingsScreen({
    super.key,
    required this.name,
    required this.email,
    required this.isDarkMode,
    required this.language,
    required this.paymentEnabled,
    required this.onThemeChanged,
    required this.onProfileUpdated,
    required this.onLanguageChanged,
    required this.onPaymentEnabledChanged,
  });

  @override
  Widget build(BuildContext context) {
    final texts = localizedText(language);

    return Scaffold(
      appBar: AppBar(title: const Text("Profile")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            child: ListTile(
              leading: const CircleAvatar(radius: 30, child: Icon(Icons.person, size: 40)),
              title: Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(email),
              trailing: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => EditProfileScreen(
                        currentName: name,
                        currentEmail: email,
                        onProfileUpdated: onProfileUpdated,
                      ),
                    ),
                  );
                },
                child: Text(texts["editProfile"]!),
              ),
            ),
          ),
          const SizedBox(height: 20),

          Text(texts["appSettings"]!, style: const TextStyle(fontWeight: FontWeight.bold)),

          ListTile(
            leading: const Icon(Icons.language),
            title: Text(texts["languageOption"]!),
            subtitle: Text(language == "EN" ? "English" : "తెలుగు"),
            trailing: DropdownButton<String>(
              value: language,
              items: const [
                DropdownMenuItem(value: "EN", child: Text("English")),
                DropdownMenuItem(value: "TE", child: Text("తెలుగు")),
              ],
              onChanged: (val) {
                if (val != null) onLanguageChanged(val);
              },
            ),
          ),

          SwitchListTile(
            title: Text(texts["mode"]!),
            subtitle: Text(isDarkMode ? texts["dark"]! : texts["light"]!),
            value: isDarkMode,
            onChanged: onThemeChanged,
          ),

          SwitchListTile(
            title: Text(texts["paymentEnabled"]!),
            subtitle: Text(paymentEnabled ? texts["paymentEnabledOn"]! : texts["paymentEnabledOff"]!),
            value: paymentEnabled,
            onChanged: onPaymentEnabledChanged,
          ),

          ListTile(
            leading: const Icon(Icons.notifications),
            title: Text(texts["notification"]!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => NotificationScreen(language: language)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.help),
            title: Text(texts["help"]!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => HelpScreen(language: language)));
            },
          ),

          const Divider(),

          Text(texts["myAccount"]!, style: const TextStyle(fontWeight: FontWeight.bold)),

          ListTile(
            leading: const Icon(Icons.payment),
            title: Text(texts["payment"]!),
            enabled: paymentEnabled,
            onTap: paymentEnabled
                ? () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PaymentScreen(language: language, userName: name, userEmail: email),
                      ),
                    );
                  }
                : null,
            trailing: paymentEnabled ? null : const Tooltip(message: 'Payments disabled', child: Icon(Icons.lock, size: 18)),
          ),
          ListTile(
            leading: const Icon(Icons.favorite),
            title: Text(texts["saved"]!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => SavedScreen(language: language)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.privacy_tip),
            title: Text(texts["privacy"]!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => PrivacyScreen(language: language)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.description),
            title: Text(texts["termsConditions"]!),
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => TermsConditionsScreen(language: language)));
            },
          ),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(texts["logout"]!),
            onTap: () {
              _showLogoutDialog(context, texts);
            },
          ),
        ],
      ),
    );
  }

  void _showLogoutDialog(BuildContext context, Map<String, String> texts) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(texts["logout"]!),
        content: Text(texts["logoutConfirm"]!),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text(texts["cancel"]!)),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(texts["loggedOut"]!)));
            },
            child: Text(texts["yesLogout"]!),
          ),
        ],
      ),
    );
  }
}
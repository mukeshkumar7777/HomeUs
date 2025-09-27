import 'package:flutter/material.dart';
import '../localization.dart';

class NotificationScreen extends StatelessWidget {
  final String language;
  const NotificationScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final texts = localizedText(language);

    return Scaffold(
      appBar: AppBar(title: Text(texts["notification"]!)),
      body: ListView(
        children: const [
          ListTile(title: Text("🔔 Payment Reminder")),
          ListTile(title: Text("📢 New Updates Available")),
          ListTile(title: Text("📩 Messages from Support")),
        ],
      ),
    );
  }
}
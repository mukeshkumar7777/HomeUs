import 'package:flutter/material.dart';
import '../localization.dart';

class HelpScreen extends StatelessWidget {
  final String language;
  const HelpScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final texts = localizedText(language);

    return Scaffold(
      appBar: AppBar(title: Text(texts["help"]!)),
      body: ListView(
        children: const [
          ListTile(leading: Icon(Icons.call), title: Text("Call Us"), subtitle: Text("+91 9876543210")),
          ListTile(leading: Icon(Icons.message), title: Text("Message Us"), subtitle: Text("Chat with our support team")),
          ListTile(leading: Icon(Icons.email), title: Text("Email Us"), subtitle: Text("support@example.com")),
        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: const Color(0xFFF7C948),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('About HomeUs', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 18),
            const Text('HomeUs is your trusted platform to find, rent, and manage properties across cities. We connect owners and tenants with ease and security.'),
            const SizedBox(height: 18),
            const Text('Developed by Team HomeUs', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            const Text('Contact: team@homeus.com'),
            const SizedBox(height: 18),
            const Text('Version 1.0.0'),
          ],
        ),
      ),
    );
  }
}

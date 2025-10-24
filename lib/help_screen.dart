import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        backgroundColor: const Color(0xFFF7C948),
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Help & Support', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
              const SizedBox(height: 18),
              const Text('For any queries or support, contact us at:', style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.email, color: Colors.amber),
                  SizedBox(width: 8),
                  Text('support@homeus.com', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: const [
                  Icon(Icons.phone, color: Colors.amber),
                  SizedBox(width: 8),
                  Text('+91 98765 43210', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              const Text('Working Hours: 9:00 AM - 8:00 PM (Mon-Sat)', style: TextStyle(fontSize: 15)),
              const SizedBox(height: 18),
              const Text('FAQs', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              const Text('Q: How do I book a property?\nA: Browse listings and tap on a property to view details and contact the owner.'),
              const SizedBox(height: 8),
              const Text('Q: How do I add to wishlist?\nA: Tap the heart icon on any property.'),
              const SizedBox(height: 8),
              const Text('Q: Is there a customer support number?\nA: Yes, call us at +91 98765 43210 during working hours.'),
              const SizedBox(height: 8),
              const Text('Q: Can I list my property?\nA: Yes, property owners can contact us to list their property.'),
              const SizedBox(height: 8),
              const Text('Q: How do I reset my password?\nA: Use the Forgot Password option on the login screen.'),
              const SizedBox(height: 18),
              const Text('Still need help? Email or call us and our team will assist you as soon as possible.', style: TextStyle(fontSize: 15)),
            ],
          ),
        ),
      ),
    );
  }
}

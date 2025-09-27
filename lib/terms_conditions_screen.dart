import 'package:flutter/material.dart';
import '../localization.dart';

class TermsConditionsScreen extends StatelessWidget {
  final String language;
  const TermsConditionsScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final texts = localizedText(language);

    return Scaffold(
      appBar: AppBar(title: Text(texts["termsConditions"]!)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              "1. Acceptance of Terms",
              [
                "By using HomeUs, you agree to be bound by these Terms and Conditions.",
                "If you do not agree to these terms, please do not use our service.",
                "We reserve the right to modify these terms at any time with notice."
              ],
            ),
            _buildSection(
              "2. Service Description",
              [
                "HomeUs is a platform connecting property owners (Hosts) with renters (Guests).",
                "We facilitate bookings but are not a party to rental agreements.",
                "We provide tools for communication, payment processing, and booking management.",
                "We do not own, operate, or manage any properties listed on our platform."
              ],
            ),
            _buildSection(
              "3. User Accounts",
              [
                "You must be at least 18 years old to create an account.",
                "You are responsible for maintaining account security and password confidentiality.",
                "You must provide accurate and complete information.",
                "One person or entity may not maintain multiple accounts.",
                "You are responsible for all activities under your account."
              ],
            ),
            _buildSection(
              "4. Host Responsibilities",
              [
                "Accurately describe your property, including amenities and limitations.",
                "Provide clean, safe, and habitable accommodations.",
                "Honor confirmed bookings and provide access as agreed.",
                "Respond promptly to guest inquiries and issues.",
                "Comply with all local laws and regulations.",
                "Maintain appropriate insurance coverage.",
                "Respect guest privacy and property rights."
              ],
            ),
            _buildSection(
              "5. Guest Responsibilities",
              [
                "Use the property only for its intended purpose.",
                "Respect house rules and property guidelines.",
                "Treat the property and its contents with care.",
                "Report any damages or issues immediately.",
                "Comply with check-in/check-out procedures.",
                "Respect noise levels and neighbor considerations.",
                "Follow all applicable laws and regulations."
              ],
            ),
            _buildSection(
              "6. Booking and Payment",
              [
                "Bookings are confirmed upon payment processing.",
                "Payment is processed securely through our payment partners.",
                "Prices are subject to change until booking confirmation.",
                "Additional fees may apply for cleaning, security deposits, or damages.",
                "Refunds are subject to our cancellation policy.",
                "We may hold funds in escrow until check-in completion."
              ],
            ),
            _buildSection(
              "7. Cancellation Policy",
              [
                "Cancellation terms vary by property and booking type.",
                "Guests may cancel within specified timeframes for full refunds.",
                "Hosts may cancel bookings with appropriate notice and penalties.",
                "Force majeure events may affect cancellation policies.",
                "Refunds are processed within 5-10 business days.",
                "Service fees are generally non-refundable."
              ],
            ),
            _buildSection(
              "8. Prohibited Activities",
              [
                "Illegal activities or violations of local laws",
                "Parties, events, or gatherings without host permission",
                "Smoking in non-smoking properties",
                "Pets in pet-free properties",
                "Subletting or reselling bookings",
                "Harassment or discrimination of other users",
                "Fraudulent or misleading information",
                "Attempting to circumvent our platform or fees"
              ],
            ),
            _buildSection(
              "9. Content and Intellectual Property",
              [
                "You retain ownership of content you upload.",
                "You grant us license to use content for platform operation.",
                "You must have rights to all content you upload.",
                "We may remove content that violates our policies.",
                "Our platform and technology are protected by intellectual property laws.",
                "You may not copy, modify, or distribute our proprietary content."
              ],
            ),
            _buildSection(
              "10. Dispute Resolution",
              [
                "We encourage direct communication between hosts and guests.",
                "Our customer support team can assist with disputes.",
                "Disputes may be subject to binding arbitration.",
                "Class action waivers may apply.",
                "Governing law is determined by our jurisdiction.",
                "We are not liable for disputes between users."
              ],
            ),
            _buildSection(
              "11. Limitation of Liability",
              [
                "Our service is provided 'as is' without warranties.",
                "We are not liable for property conditions or host/guest conduct.",
                "Our liability is limited to the amount paid for our service.",
                "We are not responsible for third-party services or content.",
                "Force majeure events may limit our obligations.",
                "Some jurisdictions may not allow liability limitations."
              ],
            ),
            _buildSection(
              "12. Indemnification",
              [
                "You agree to indemnify us against claims arising from your use of the service.",
                "This includes claims related to your content or conduct.",
                "You are responsible for your own legal costs.",
                "We may assume defense of claims at our discretion."
              ],
            ),
            _buildSection(
              "13. Termination",
              [
                "We may suspend or terminate accounts for policy violations.",
                "You may terminate your account at any time.",
                "Termination does not affect existing bookings.",
                "We may retain certain information after termination.",
                "Outstanding payments remain due after termination."
              ],
            ),
            _buildSection(
              "14. Privacy and Data Protection",
              [
                "Your privacy is important to us. Please review our Privacy Policy.",
                "We collect and use data as described in our Privacy Policy.",
                "You have rights regarding your personal data.",
                "We implement appropriate security measures.",
                "Data may be transferred internationally with safeguards."
              ],
            ),
            _buildSection(
              "15. Governing Law and Jurisdiction",
              [
                "These terms are governed by the laws of [Your Jurisdiction].",
                "Disputes will be resolved in the courts of [Your Jurisdiction].",
                "International users may be subject to different laws.",
                "We comply with applicable international regulations."
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Contact Information",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "For questions about these Terms and Conditions:\n"
              "Email: legal@homeus.com\n"
              "Phone: +1-800-HOMEUS\n"
              "Address: 123 Rental Street, City, State 12345",
            ),
            const SizedBox(height: 20),
            const Text(
              "Last Updated: December 2024",
              style: TextStyle(fontStyle: FontStyle.italic, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> points) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          ...points.map((point) => Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 4),
            child: Text(point),
          )),
        ],
      ),
    );
  }
}

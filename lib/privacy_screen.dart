import 'package:flutter/material.dart';
import '../localization.dart';

class PrivacyScreen extends StatelessWidget {
  final String language;
  const PrivacyScreen({super.key, required this.language});

  @override
  Widget build(BuildContext context) {
    final texts = localizedText(language);

    return Scaffold(
      appBar: AppBar(title: Text(texts["privacy"]!)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSection(
              "1. Information We Collect",
              [
                "• Personal Information: Name, email address, phone number, profile photo",
                "• Property Information: Address, photos, amenities, pricing, availability (for hosts)",
                "• Booking Information: Check-in/out dates, guest count, special requests",
                "• Payment Information: Billing address, payment method details (securely processed)",
                "• Communication Data: Messages between hosts and guests",
                "• Usage Data: App interactions, search history, preferences",
                "• Device Information: Device type, operating system, unique device identifiers",
                "• Location Data: Approximate location for property search (with permission)"
              ],
            ),
            _buildSection(
              "2. How We Use Your Information",
              [
                "• Provide and maintain our home rental platform",
                "• Process bookings and facilitate payments",
                "• Enable communication between hosts and guests",
                "• Send booking confirmations, updates, and important notifications",
                "• Improve our services and develop new features",
                "• Prevent fraud and ensure platform safety",
                "• Comply with legal obligations and resolve disputes",
                "• Personalize your experience and show relevant properties"
              ],
            ),
            _buildSection(
              "3. Information Sharing",
              [
                "• With Hosts/Guests: Essential booking information for successful transactions",
                "• Payment Processors: To process payments securely",
                "• Service Providers: Analytics, customer support, cloud storage (under strict agreements)",
                "• Legal Requirements: When required by law or to protect rights and safety",
                "• Business Transfers: In case of merger, acquisition, or asset sale",
                "• We DO NOT sell your personal information to third parties"
              ],
            ),
            _buildSection(
              "4. Data Security",
              [
                "• Industry-standard encryption for data transmission and storage",
                "• Regular security audits and vulnerability assessments",
                "• Access controls and employee training on data protection",
                "• Secure payment processing with PCI DSS compliance",
                "• Incident response procedures for any security breaches"
              ],
            ),
            _buildSection(
              "5. Your Rights and Choices",
              [
                "• Access and update your personal information",
                "• Delete your account and associated data",
                "• Opt-out of marketing communications",
                "• Control location and notification permissions",
                "• Request data portability",
                "• Withdraw consent where applicable"
              ],
            ),
            _buildSection(
              "6. Data Retention",
              [
                "• Account data: Until account deletion or 3 years of inactivity",
                "• Booking records: 7 years for legal and tax compliance",
                "• Communication data: 2 years after booking completion",
                "• Marketing data: Until consent withdrawal",
                "• Analytics data: Anonymized after 2 years"
              ],
            ),
            _buildSection(
              "7. Cookies and Tracking",
              [
                "• Essential cookies for app functionality",
                "• Analytics cookies to improve user experience",
                "• Marketing cookies (with consent)",
                "• You can manage cookie preferences in settings"
              ],
            ),
            _buildSection(
              "8. International Transfers",
              [
                "• Data may be transferred to countries with adequate protection",
                "• We ensure appropriate safeguards for international transfers",
                "• Standard contractual clauses where necessary"
              ],
            ),
            _buildSection(
              "9. Children's Privacy",
              [
                "• Our service is not intended for children under 16",
                "• We do not knowingly collect data from children",
                "• If we discover such data, we will delete it promptly"
              ],
            ),
            _buildSection(
              "10. Changes to This Policy",
              [
                "• We may update this policy periodically",
                "• Significant changes will be communicated via email or app notification",
                "• Continued use constitutes acceptance of updated policy"
              ],
            ),
            const SizedBox(height: 20),
            const Text(
              "Contact Us",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "For privacy-related questions or requests, contact us at:\n"
              "Email: privacy@homeus.com\n"
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
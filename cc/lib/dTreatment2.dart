import 'package:flutter/material.dart';
import 'base_page.dart'; // Import BasePage

class DTreatmentPage extends StatelessWidget {
  final Map<String, String> treatment;

  const DTreatmentPage({Key? key, required this.treatment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2; // Disease Treatment is the 3rd item in the bottom nav

    return BasePage(
      title: 'Disease Treatment',
      selectedIndex: selectedIndex,
      onItemTapped: (index) {
        // Handle navigation logic if needed (if BasePage needs to switch pages)
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Treatment Name in Bold, Centered at the Top
            Center(
              child: Text(
                treatment['label']!, // Treatment Name
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacing between name and other content

            // Treatment Image
            Image.asset(treatment['image']!),
            const SizedBox(height: 16),

            // Treatment Description
            Text(
              'Description: ${treatment['description']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            // Treatment Method
            Text(
              'Treatment Method: ${treatment['treatmentMethod']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            // Dosages
            Text(
              'Dosages: ${treatment['dosages']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            // Notes
            Text(
              'Notes: ${treatment['notes']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

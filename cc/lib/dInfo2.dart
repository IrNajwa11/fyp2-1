import 'package:flutter/material.dart';
import 'base_page.dart'; // Import BasePage

class DiseaseInfoPage extends StatelessWidget {
  final Map<String, String> disease;

  const DiseaseInfoPage({Key? key, required this.disease}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1; // Disease Info is the 2nd item in the bottom nav

    return BasePage(
      title: 'Disease Info', // Keeping the title consistent
      selectedIndex: selectedIndex,
      onItemTapped: (index) {
        // Handle navigation logic if needed (if BasePage needs to switch pages)
      },
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Disease Name in Bold, Centered at the Top
            Center(
              child: Text(
                disease['label']!, // Disease Name
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 20), // Spacing between name and other content

            // Disease Image
            Image.asset(disease['image']!),
            const SizedBox(height: 16),

            // Disease Description
            Text(
              'Description: ${disease['description']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            // Causal Agent
            Text(
              'Causal Agent: ${disease['causalAgent']}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 8),

            // Symptoms
            Text(
              'Symptoms: ${disease['symptoms']}',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}

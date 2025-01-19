import 'package:flutter/material.dart';
import 'dTreatmentData.dart';
import 'disease.dart'; // Import the Disease class
import 'base_page.dart'; // Import BasePage

class DTreatmentPage2 extends StatelessWidget {
  final Disease disease;

  DTreatmentPage2({required this.disease});

  @override
  Widget build(BuildContext context) {
    final diseaseTreatment = DiseaseTreatmentData.treatmentList.firstWhere(
      (treatment) => treatment['label'] == disease.name,
      orElse: () => {},
    );

    // Define adjustable text styles
    final TextStyle titleStyle = TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Arial', // Use Arial font
    );
    final TextStyle bodyStyle = TextStyle(
      fontSize: 22.0,
      height: 1.5, // Increased line spacing for better readability
      fontFamily: 'Arial', // Use Arial font
    );

    // Fixed border color for the disease image
    final borderColor = const Color(0xFF598230);

    // Determine the gradient based on the theme
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final containerGradient = LinearGradient(
      colors: isLightMode
          ? [
              const Color(0xFF598230),
              Color.fromARGB(255, 235, 220, 220)
            ] // Gradient for light mode
          : [
              const Color(0xFF598230),
              const Color(0xFF242424)
            ], // Gradient for dark mode
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.02, 1],
    );

    return BasePage(
      title: 'Disease Treatment',
      selectedIndex: 3,
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Wrap image in a container with border
                Center(
                  child: Semantics(
                    label: 'Image of ${diseaseTreatment['label']} disease',
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: borderColor,
                            width: 5.0), // Border color and width
                        borderRadius: BorderRadius.circular(
                            10.0), // Optional: to round the corners of the border
                      ),
                      child: Image.asset(
                        diseaseTreatment['image'],
                        height: 150,
                        width: 200,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20), // Space between the image and content

                // Gradient container for the details
                Container(
                  width: double.infinity, // Full width
                  decoration: BoxDecoration(
                    gradient: containerGradient,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        label: '${diseaseTreatment['label']} Treatment',
                        child: Text(
                          diseaseTreatment['label'] ?? 'Unknown Disease',
                          style: titleStyle,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Semantics(
                        label:
                            'Disease description: ${diseaseTreatment['description']}',
                        child: Text(
                          diseaseTreatment['description'] ??
                              'No description available.',
                          style: bodyStyle,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Treatments
                      Semantics(
                        label: 'Treatments section',
                        child: Text(
                          'Treatments:',
                          style: titleStyle.copyWith(fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...buildTreatmentSections(
                          diseaseTreatment['treatments'], bodyStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Helper method for displaying treatment sections
  List<Widget> buildTreatmentSections(
      Map<String, List<String>> treatments, TextStyle bodyStyle) {
    return treatments.entries.map((entry) {
      final part = entry.key;
      final items = entry.value;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: 'Part: $part',
              child: Text(
                part,
                style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            ...buildNumberedList(items, bodyStyle),
          ],
        ),
      );
    }).toList();
  }

  // Helper method to create a numbered list of treatments
  List<Widget> buildNumberedList(List<String> items, TextStyle bodyStyle) {
    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final treatment = entry.value;

      return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
        child: Semantics(
          label: 'Treatment number ${index + 1} is $treatment',
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${index + 1}. ',
                style: bodyStyle,
              ),
              Expanded(
                child: Text(
                  treatment,
                  style: bodyStyle,
                  textAlign: TextAlign.left, // Left-aligned text
                ),
              ),
            ],
          ),
        ),
      );
    }).toList();
  }
}

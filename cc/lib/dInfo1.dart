import 'package:flutter/material.dart';
import 'dInfo2.dart';
import 'disease.dart'; // Import the Disease class
import 'base_page.dart';

class DiseaseInfoPage1 extends StatelessWidget {
  final List<Disease> diseases = [
    Disease('Corn Cercospora Leaf Spot', 'assets/ccls.jpg'),
    Disease('Corn Common Rust', 'assets/ccr.jpg'),
    Disease('Potato Early Blight', 'assets/peb.jpg'),
    Disease('Potato Late Blight', 'assets/plb.jpg'),
    Disease('Tomato Early Blight', 'assets/teb.jpg'),
    Disease('Tomato Late Blight', 'assets/tlb.jpg'),
    Disease('Tomato Yellow Leaf Curl Virus', 'assets/ylcv.jpg'),
  ];

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Disease Information',
      selectedIndex: 1, // Update if needed to reflect the correct navigation index
      onItemTapped: (index) {
        // Handle bottom navigation actions if applicable
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: diseases.map((disease) {
              return Column(
                children: [
                  _buildDiseaseButton(context, disease),
                  const SizedBox(height: 20),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildDiseaseButton(BuildContext context, Disease disease) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DiseaseInfoPage2(disease: disease),
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: 350,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Color(0xFFBB593E),
                width: 3.0,
              ),
              borderRadius: BorderRadius.circular(8.0), // Rounded button
            ),
            child: Row(
              children: [
                // Disable semantics for the image
                Semantics(
                  excludeSemantics: true,
                  child: Container(
                    color: Color(0xFFBB593E),
                    width: 100,
                    alignment: Alignment.center,
                    child: Image.asset(
                      disease.imagePath,
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Semantics(
                      button:
                          true, // This marks the widget as a button for screen readers
                      label:
                          'View Disease Info of: ${disease.name}', // This will be read by screen readers
                      child: Text(
                        disease.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Arial', // Ensure Arial font is used
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

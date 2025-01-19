import 'package:flutter/material.dart';
import 'base_page.dart';
import 'disease.dart'; // Import the Disease class
import 'dTreatment2.dart'; // Import DTreatmentPage2

class DTreatmentPage1 extends StatelessWidget {
  final List<Disease> treatmentLabel = [
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
      title: 'Disease Treatment',
      selectedIndex: 3, // Update if needed to reflect the correct navigation index
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: treatmentLabel.map((disease) {
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
            builder: (context) => DTreatmentPage2(
              disease: disease, // Pass the entire disease object
            ),
          ),
        );
      },
      child: Semantics(
        label: 'View Disease Info of  ${disease.name}', // Indicate this is a clickable button
        button: true, // Indicate this is a button for screen readers
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8), // Set the border radius to 8 for rounded corners
          ),
          child: SizedBox(
            width: 350,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF528222),
                  width: 3.0,
                ),
                borderRadius: BorderRadius.circular(8), // Apply rounded corners to the container
              ),
              child: Row(
                children: [
                  Container(
                    color: const Color(0xFF528222), // Updated button color
                    width: 100,
                    alignment: Alignment.center,
                    child: Image.asset(
                      disease.imagePath, // Use image path from Disease
                      fit: BoxFit.cover,
                      width: 90,
                      height: 90,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                        disease.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Arial', // Set font to Arial
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

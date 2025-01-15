import 'package:flutter/material.dart';
import 'base_page.dart';
import 'disease.dart'; // Import the Disease class
import 'dTreatment2.dart'; // Import DTreatmentPage2

class DTreatmentPage1 extends StatelessWidget {
  final List<Disease> treatmentLabel = [
    Disease('Corn Cercospora Leaf Spot', 'assets/Corn_Grey Leaf Spot.jpg'),
    Disease('Corn Common Rust', 'assets/Corn_Common Rust.jpg'),
    Disease('Potato Early Blight', 'assets/Potato_Early Blight.jpg'),
    Disease('Potato Late Blight', 'assets/plb.JPG'),
    Disease('Tomato Early Blight', 'assets/teb.JPG'),
    Disease('Tomato Late Blight', 'assets/tlb.JPG'),
    Disease('Tomato Yellow Leaf Curl Virus', 'assets/tylcv.JPG'),
    Disease('Tomato Mosaic Virus', 'assets/Tomato_Mosaic Virus.png'),
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
        label: 'Tap to view treatment for ${disease.name}',
        button: true, // Indicate this is a button for screen readers
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: 350,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color(0xFF528222),
                  width: 3.0,
                ),
              ),
              child: Row(
                children: [
                  Semantics(
                    label: '${disease.name} image',
                    child: Container(
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
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Semantics(
                        label: 'Disease name: ${disease.name}',
                        child: Text(
                          disease.name,
                          textAlign: TextAlign.left,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
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

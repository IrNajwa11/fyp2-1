import 'package:flutter/material.dart';
import 'base_page.dart';
import 'disease.dart';
import 'dTreatment2.dart';

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
      selectedIndex: 3,
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
              disease: disease,
            ),
          ),
        );
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
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
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Semantics(
                  excludeSemantics: true,
                  child: Container(
                    color: const Color(0xFF528222),
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
                      label: 'View Disease Treatment of ${disease.name}',
                      button: true,
                      child: Text(
                        disease.name,
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.normal,
                          fontFamily: 'Arial',
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

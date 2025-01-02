import 'package:flutter/material.dart';
import 'dInfo2.dart';
import 'dInfoData.dart';
import 'base_page.dart';

class DiseaseInfoPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 1; // Disease Info is the 2nd item in the bottom nav

    return BasePage(
      title: 'Disease Info',
      selectedIndex: selectedIndex,
      onItemTapped: (index) {
        // Handle navigation logic if needed (if BasePage needs to switch pages)
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: DiseaseInfoData.diseaseList.length,
          itemBuilder: (context, index) {
            var disease = DiseaseInfoData.diseaseList[index];
            return _buildCustomButton(
              context,
              disease['label']!,
              Colors.blue, // You can change the color as needed
              Icons.info_outline, // You can change the icon as needed
              () {
                // Navigate to Disease Info page with specific disease info
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DiseaseInfoPage(disease: disease),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildCustomButton(BuildContext context, String label, Color color, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(color: color),
          ),
          child: Row(
            children: [
              Container(
                color: color,
                width: 100,
                alignment: Alignment.center,
                child: Icon(icon, color: Colors.white, size: 50),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    label,
                    textAlign: TextAlign.left,
                    style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

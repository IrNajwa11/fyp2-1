import 'package:flutter/material.dart';
import 'dTreatment2.dart';  // Adjust the import for the next treatment page
import 'base_page.dart';
import 'dTreatmentData.dart';

class DTreatmentPage1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 3; // Disease Treatment is the 3rd item in the bottom nav

    return BasePage(
      title: 'Disease Treatment',
      selectedIndex: selectedIndex,
      onItemTapped: (index) {
        // Handle navigation logic if needed (if BasePage needs to switch pages)
      },
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: ListView.builder(
          itemCount: DiseaseTreatmentData.treatmentList.length,
          itemBuilder: (context, index) {
            var treatment = DiseaseTreatmentData.treatmentList[index];
            return _buildCustomButton(
              context,
              treatment['label']!,  // Assuming treatment has a 'label'
              Colors.green,  // You can change the color as needed
              Icons.medical_services_outlined,  // You can change the icon as needed
              () {
                // Navigate to Disease Treatment page with specific treatment info
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DTreatmentPage(treatment: treatment),
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

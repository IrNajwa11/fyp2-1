import 'package:cc/dTreatment2.dart';
import 'package:flutter/material.dart';
import 'dScanner_page.dart';
import 'dInfo1.dart';
import 'dTreatment1.dart';
import 'fav_page.dart';
import 'base_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2; // Home is the 3rd item in the bottom nav

    return BasePage(
      title: 'Home',
      selectedIndex: selectedIndex,
      onItemTapped: (index) {
        // Handle navigation logic if needed (if BasePage needs to switch pages)
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildAccessibleButton(
                context,
                'Disease Scanner',
                const Color(0xFF0A8484),
                Icons.camera_alt_sharp,
                'Navigate to Disease Scanner page',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DScannerPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildAccessibleButton(
                context,
                'Disease Info',
                const Color(0XFFBB593E),
                Icons.menu_book_sharp,
                'Navigate to Disease Info page',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiseaseInfoPage1()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildAccessibleButton(
                context,
                'Disease Treatment',
                const Color(0xFF528222),
                Icons.medical_services_sharp,
                'Navigate to Disease Treatment page',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DTreatmentPage1()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildAccessibleButton(
                context,
                'Favourite',
                const Color(0xFFD03B80),
                Icons.favorite,
                'Navigate to Favourite page',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavouritePage()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAccessibleButton(
      BuildContext context,
      String label,
      Color color,
      IconData icon,
      String semanticLabel,
      VoidCallback onTap) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: SizedBox(
            width: 350,
            height: 100,
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: color,
                  width: 3.0,
                ),
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
        ),
      ),
    );
  }
}

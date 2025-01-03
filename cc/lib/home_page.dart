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
              _buildCustomButton(
                context,
                'Disease Scanner',
                const Color(0xFF0A8484),
                Icons.camera_alt_sharp,
                () {
                  // Navigate to Disease Scanner page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DScannerPage()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildCustomButton(
                context,
                'Disease Info',
                const Color(0xFFBF5537),
                Icons.menu_book_sharp,
                () {
                  // Navigate to Disease Info page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DiseaseInfoPage1()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildCustomButton(
                context,
                'Disease Treatment',
                const Color(0xFF598230),
                Icons.medical_services_sharp,
                () {
                  // Navigate to Disease Treatment page
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DTreatmentPage1()),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildCustomButton(
                context,
                'History',
                const Color(0xFF897310),
                Icons.history,
                () {
                  // Navigate to Favourite page (History is likely a favourite page)
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavouritePage.empty()),
                  );
                },
              ),
            ],
          ),
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
        child: SizedBox(
          width: 350, // Adjust this value to control the button width
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 3.0, // Increase this value to make the border thicker
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
    );
  }
}

import 'package:flutter/material.dart';
import 'dScanner_page.dart';
import 'dInfo1.dart';
import 'dTreatment1.dart';
import 'base_page.dart';
import 'fav_page.dart';

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
      child: Center( // Center the entire child widget
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Ensure buttons are centered vertically
            crossAxisAlignment: CrossAxisAlignment.center, // Ensure buttons are centered horizontally
            mainAxisSize: MainAxisSize.min, // Ensure the column takes only as much space as needed
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
                'Favourite Prediction',
                const Color(0xFFD03B80),
                Icons.favorite,
                'Navigate to Favourite Prediction page',
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => FavoritePage()),
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
      button: true,  // Mark it as a button for accessibility
      label: semanticLabel, // Ensure screen readers announce the correct navigation action
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white, // Change the text color here (set to white for example)
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: color, width: 3),
          ),
          minimumSize: Size(350, 100), // Ensure the button is large enough
        ),
        onPressed: onTap,
        child: Row(
          children: [
            Container(
              width: 100,
              alignment: Alignment.center,
              child: Icon(icon, color: Colors.white, size: 50),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  label,  // Show the button's title (optional for visual users)
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial', // Clear and accessible font
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
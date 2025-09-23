import 'package:flutter/material.dart';
import 'dScanner_page.dart';
import 'dInfo1.dart';
import 'dTreatment1.dart';
import 'base_page.dart';
import 'fav_page.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    int selectedIndex = 2;

    return BasePage(
      title: 'Home',
      selectedIndex: selectedIndex,
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
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

  Widget _buildAccessibleButton(BuildContext context, String label, Color color,
      IconData icon, String semanticLabel, VoidCallback onTap) {
    return Semantics(
      button: true,
      label: semanticLabel,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(color: color, width: 3),
          ),
          minimumSize: Size(350, 100),
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
                  label,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Arial',
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

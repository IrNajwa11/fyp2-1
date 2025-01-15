import 'package:flutter/material.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
import 'dScanner_page.dart'; // Import pages for navigation
import 'dInfo1.dart';
import 'home_page.dart';
import 'dTreatment1.dart';
import 'fav_page.dart';

class BasePage extends StatelessWidget {
  final String title;
  final int selectedIndex;
  final Function(int) onItemTapped;
  final Widget child;

  const BasePage({
    Key? key,
    required this.title,
    required this.selectedIndex,
    required this.onItemTapped,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80, // Increase height to prevent overflow
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: themeProvider.isDarkMode
                  ? [Color(0xFF0A8484), Colors.black]
                  : [Color(0xFF0A8484), Colors.white],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.ellipsis, // Prevent title overflow
        ),
        centerTitle: true,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0), // Adjust height for spacing
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0), // Add vertical padding
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildLogoSection(),
                _buildThemeToggleSection(themeProvider),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: child,
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(selectedIndex, onItemTapped, [
        Color(0xFF0A8484),
        Color(0xFFBB593E),
        Color(0xFF4E73C7),
        Color(0xFF528222),
        Color( 0xFFD03B80),
      ], context),
    );
  }

  Widget _buildLogoSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12.0), // Adjust padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/cropCare_logo.png',
            height: 50,
          ),
          const SizedBox(height: 10), // Increase height for spacing
          const Text('Crop Care', style: TextStyle(fontSize: 18)),
        ],
      ),
    );
  }

  Widget _buildThemeToggleSection(ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 12.0), // Adjust padding
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          GestureDetector(
            onTap: themeProvider.toggleTheme,
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: themeProvider.isDarkMode ? Colors.white : Colors.black,
              ),
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                themeProvider.isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: themeProvider.isDarkMode ? Colors.black : Colors.white,
                size: 20,
              ),
            ),
          ),
          const SizedBox(height: 10), // Increase height for spacing
          Text(
            themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(int selectedIndex, Function(int) onItemTapped, List<Color> itemColors, BuildContext context) {
    return BottomNavigationBar(
      items: List.generate(itemColors.length, (index) {
        return BottomNavigationBarItem(
          icon: Container(
            decoration: BoxDecoration(
              color: selectedIndex == index ? itemColors[index] : Colors.transparent,
              border: Border.all(color: itemColors[index], width: 2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              _getIconForIndex(index),
              color: selectedIndex == index ? Colors.white : itemColors[index],
            ),
          ),
          label: _getLabelForIndex(index),
        );
      }),
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);
        _navigateToPage(context, index); // Pass context to navigate
      },
    );
  }

  void _navigateToPage(BuildContext context, int index) {
    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DScannerPage()), // Navigate to Scanner page
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DiseaseInfoPage1()), // Navigate to Info page
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomePage()), // Navigate to Home page
        );
        break;
      case 3:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => DTreatmentPage1()), // Navigate to Treatment page
        );
        break;
      case 4:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => FavoritePage()), // Navigate to History page
        );
        break;
      default:
        break;
    }
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0: return Icons.camera_alt; // Scanner
      case 1: return Icons.menu_book_sharp; // Info
      case 2: return Icons.home; // Home
      case 3: return Icons.medical_services_sharp; // Treatment
      case 4: return Icons.favorite; // History
      default: return Icons.home; // Default icon
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0: return 'Scanner';
      case 1: return 'Info';
      case 2: return 'Home';
      case 3: return 'Treatment';
      case 4: return 'Favourite';
      default: return '';
    }
  }
}

import 'package:flutter/material.dart';
import 'theme_provider.dart';
import 'package:provider/provider.dart';
import 'dScanner_page.dart'; 
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
      appBar: _buildAppBar(context, themeProvider),
      body: _buildBody(child),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  AppBar _buildAppBar(BuildContext context, ThemeProvider themeProvider) {
    return AppBar(
      toolbarHeight: 80,
      flexibleSpace: _buildAppBarBackground(themeProvider),
      title: _buildAppBarTitle(),
      centerTitle: true,
      bottom: _buildAppBarBottom(themeProvider),
    );
  }

  Container _buildAppBarBackground(ThemeProvider themeProvider) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: themeProvider.isDarkMode
              ? [Color(0xFF0A8484), Colors.black]
              : [Color(0xFF0A8484), Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }

  Semantics _buildAppBarTitle() {
    return Semantics(
      label: '$title Page',
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          fontFamily: 'Arial',
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  PreferredSize _buildAppBarBottom(ThemeProvider themeProvider) {
    return PreferredSize(
      preferredSize: const Size.fromHeight(80.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildLogoSection(),
            _buildThemeToggleSection(themeProvider),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(Widget child) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }

  Widget _buildLogoSection() {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, top: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSemanticsImage('Logo - Crop Care', 'assets/cropCare_logo.png', 50),
          const SizedBox(height: 10),
          _buildSemanticsText('Text - Crop Care', 'Crop Care', 18),
        ],
      ),
    );
  }

  Widget _buildSemanticsImage(String label, String assetPath, double height) {
    return Semantics(
      label: label,
      child: Image.asset(
        assetPath,
        height: height,
      ),
    );
  }

  Widget _buildSemanticsText(String label, String text, double fontSize) {
    return Semantics(
      label: label,
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontFamily: 'Arial',
        ),
      ),
    );
  }

  Widget _buildThemeToggleSection(ThemeProvider themeProvider) {
    return Padding(
      padding: const EdgeInsets.only(right: 16.0, top: 12.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildSemanticsThemeToggle(themeProvider),
          const SizedBox(height: 10),
          _buildSemanticsText(
            'Switch to ${themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode'}',
            themeProvider.isDarkMode ? 'Light Mode' : 'Dark Mode',
            18,
          ),
        ],
      ),
    );
  }

  Semantics _buildSemanticsThemeToggle(ThemeProvider themeProvider) {
    return Semantics(
      label: themeProvider.isDarkMode ? 'Switch to Light Mode' : 'Switch to Dark Mode',
      child: GestureDetector(
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
    );
  }

  BottomNavigationBar _buildBottomNavigationBar(BuildContext context) {
    return BottomNavigationBar(
      items: List.generate(5, (index) => _buildBottomNavItem(index)),
      currentIndex: selectedIndex,
      onTap: (index) {
        onItemTapped(index);
        _navigateToPage(context, index);
      },
      type: BottomNavigationBarType.fixed, // Ensure continuous row of icons
    );
  }

  BottomNavigationBarItem _buildBottomNavItem(int index) {
    return BottomNavigationBarItem(
      icon: Semantics(
        label: _getLabelForIndex(index),
        child: _buildNavItemIcon(index),
      ),
      label: '',
    );
  }

  Widget _buildNavItemIcon(int index) {
    final itemColors = [
      Color(0xFF0A8484),
      Color(0xFFBB593E),
      Color(0xFF4E73C7),
      Color(0xFF528222),
      Color(0xFFD03B80),
    ];

    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: itemColors[index], // Set color for the button by default
        borderRadius: BorderRadius.circular(10),
        boxShadow: selectedIndex == index
            ? [
                BoxShadow(
                  color: Colors.black.withOpacity(0.2),
                  offset: Offset(0, -5), // Elevate when selected
                  blurRadius: 8,
                ),
              ]
            : [],
      ),
      height: 50,
      width: 150,
      child: Icon(
        _getIconForIndex(index),
        color: selectedIndex == index ? Colors.white : Colors.black, // White when selected
        size: 30,  // Increased icon size
      ),
    );
  }

  IconData _getIconForIndex(int index) {
    switch (index) {
      case 0:
        return Icons.camera_alt;
      case 1:
        return Icons.menu_book;
      case 2:
        return Icons.home;
      case 3:
        return Icons.medical_services;
      case 4:
        return Icons.favorite;
      default:
        return Icons.favorite;
    }
  }

  String _getLabelForIndex(int index) {
    switch (index) {
      case 0:
        return 'Disease Scanner';
      case 1:
        return 'Disease Info';
      case 2:
        return 'Home';
      case 3:
        return 'Disease Treatment';
      case 4:
        return 'Favourite';
      default:
        return 'Unknown';
    }
  }

  void _navigateToPage(BuildContext context, int index) {
    final routes = [
      DScannerPage(),
      DiseaseInfoPage1(),
      HomePage(),
      DTreatmentPage1(),
      FavouritePage(),
    ];

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => routes[index]),
    );
  }
}

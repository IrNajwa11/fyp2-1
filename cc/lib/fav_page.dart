import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import intl package
import 'base_page.dart';

class FavoritePage extends StatelessWidget {
  static List<Map<String, dynamic>> favoriteList = []; // Static list to hold favorite data

  // Method to add a favorite item
  static void addFavorite(Map<String, dynamic> favorite) {
    favoriteList.add(favorite);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gradientColors = theme.brightness == Brightness.light
        ? [const Color(0xFFD03B80), Colors.white]
        : [const Color(0xFFD03B80), const Color(0xFF121212)];

    return BasePage(
      title: 'Favourite Diseases',
      selectedIndex: 4, // Make sure the second tab (Favorites) is selected
      onItemTapped: (index) {
        if (index == 0) {
          Navigator.pop(context); // Return to the PredictionPage when tapped
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(  // Make the content scrollable
            child: Column(
              children: favoriteList.map((favorite) {
                final disease = favorite['disease'];
                final image = favorite['image'] as File;
                final date = favorite['date']; // Get the date
                final formattedDate = _formatDate(date); // Format the date
                return Column(
                  children: [
                    _buildFavoriteItem(context, disease, image, formattedDate, favorite),
                    const SizedBox(height: 20),
                  ],
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }

  // Method to format the date into day-month-year format
  String _formatDate(String date) {
    try {
      final DateTime parsedDate = DateTime.parse(date); // Parse the date string to DateTime
      final DateFormat dateFormat = DateFormat('dd-MM-yyyy'); // Define the format
      return dateFormat.format(parsedDate); // Return the formatted date
    } catch (e) {
      return date; // If parsing fails, return the original string (you can also handle errors here)
    }
  }

  // Widget to build each favorite item
  Widget _buildFavoriteItem(BuildContext context, String disease, File image, String date, Map<String, dynamic> favorite) {
    return GestureDetector(
      onTap: () {
        // Handle tap if needed
      },
      child: Card(
        elevation: 2,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: SizedBox(
          width: 350,
          height: 100,
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color(0xFF0A8484),
                width: 2.0,
              ),
            ),
            child: Row(
              children: [
                ClipRRect(
                  child: Image.file(image, height: 95, width: 85, fit: BoxFit.cover),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          disease,
                          style: const TextStyle(fontSize: 18.0, fontWeight: FontWeight.normal),
                          overflow: TextOverflow.ellipsis,  // Allow overflow handling
                          softWrap: true,  // Allow text to wrap to the next line if necessary
                        ),
                        const SizedBox(height: 10),
                        Text(
                          'Predicted on: $date',  // Display the formatted prediction date
                          style: const TextStyle(fontSize: 14.0, color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                IconButton(
                  iconSize: 30.0,
                  icon: Icon(Icons.delete, color: Colors.red),
                  onPressed: () {
                    // Remove the favorite item
                    FavoritePage.favoriteList.remove(favorite);
                    // Refresh the UI without navigation
                    (context as Element).markNeedsBuild();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

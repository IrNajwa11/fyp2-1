import 'dart:io';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'base_page.dart'; // Import BasePage

class FavouritePage extends StatefulWidget {
  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  List<String> favoriteDiseases = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  // Load favorites from SharedPreferences
  _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoriteDiseases = prefs.getStringList('favorites') ?? [];
    });
  }

  // Delete favorite from SharedPreferences
  _deleteFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    favoriteDiseases.removeAt(index);
    await prefs.setStringList('favorites', favoriteDiseases);
    setState(() {});
  }

  // Format the date to day/month/year
  String formatDate(String dateString) {
    final DateTime date = DateTime.parse(dateString);
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Favourites',
      selectedIndex: 4,
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: favoriteDiseases.isEmpty
                ? [Text('No favorites yet', style: TextStyle(color: Colors.white))]
                : favoriteDiseases.map((fav) {
                    // Parse the data stored as a string
                    final favData = fav.split(',');
                    final imagePath = favData[0].split(':')[1].trim();
                    final disease = favData[1].split(':')[1].trim();
                    final date = favData[2].split(':')[1].trim();
                    final formattedDate = formatDate(date);

                    // Get the text color based on the theme mode
                    final textColor = Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black;

                    return Column(
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.symmetric(vertical: 10),
                          leading: Image.file(
                            File(imagePath),
                            width: 50,
                            height: 50,
                            fit: BoxFit.cover,
                          ),
                          title: Text(disease, style: TextStyle(color: textColor)),
                          subtitle: Text(formattedDate, style: TextStyle(color: textColor)),
                          trailing: IconButton(
                            icon: Icon(Icons.delete, color: Colors.red),
                            onPressed: () => _deleteFavorite(favoriteDiseases.indexOf(fav)),
                          ),
                        ),
                        Container(
                          height: 2,
                          color: Color(0xFFD03B80), // Thick separator line
                        ),
                      ],
                    );
                  }).toList(),
          ),
        ),
      ),
    );
  }
}

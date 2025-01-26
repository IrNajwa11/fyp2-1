import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'base_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  List<Map<String, String>> favoriteItems = [];

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];

    setState(() {
      favoriteItems = favorites.map((favorite) {
        final Map<String, String> data = {};
        final dataList = favorite.substring(1, favorite.length - 1).split(', ');
        for (var item in dataList) {
          final keyValue = item.split(': ');
          if (keyValue.length == 2) {
            data[keyValue[0]] = keyValue[1];
          }
        }
        return data;
      }).toList();
    });
  }

  Future<void> _deleteFavorite(int index) async {
    final prefs = await SharedPreferences.getInstance();
    List<String> favorites = prefs.getStringList('favorites') ?? [];
    favorites.removeAt(index);
    await prefs.setStringList('favorites', favorites);
    _loadFavorites();
  }

  String _formatDate(String dateString) {
    try {
      final dateTime = DateTime.parse(dateString);
      final dateFormatter = DateFormat('d/MM/yyyy');
      final timeFormatter = DateFormat('h:mm a');
      return '${dateFormatter.format(dateTime)} at ${timeFormatter.format(dateTime)}';
    } catch (e) {
      return 'Invalid date';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      title: 'Favourite Prediction',
      selectedIndex: 4,
      onItemTapped: (index) {
        // Handle bottom navigation actions if needed
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: favoriteItems.map((item) {
              final imagePath = item['imagePath'];
              final diseaseName = item['disease'] ?? 'Unknown Disease';
              final date = _formatDate(item['date'] ?? 'No date');
              return Column(
                children: [
                  Row(
  children: [
    Container(
      width: 100,
      height: 100,
      alignment: Alignment.center,
      child: imagePath != null
          ? Image.file(
              File(imagePath),
              fit: BoxFit.cover,
              width: 90,
              height: 90,
            )
          : Icon(Icons.image, size: 90),
    ),
    const SizedBox(width: 16),
    Expanded(
      child: Semantics(
        label: 'Disease: $diseaseName, Detected on $date', // Group the disease and date together
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              diseaseName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.normal,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              date,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.normal,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    ),
    // Only the delete button will be identified as a button
    Semantics(
      label: 'Delete Favorited Prediction', // Define the label for the button
      child: IconButton(
        icon: Icon(Icons.delete, color: Colors.red),
        iconSize: 40, // Increased icon size
        onPressed: () {
          // Get the index of the item clicked
          int index = favoriteItems.indexOf(item);
          _deleteFavorite(index); // Delete the item at the specific index
        },
      ),
    )
  ],
),

                  const SizedBox(height: 10),
                  Divider(color: Colors.pink, thickness: 2),
                  const SizedBox(height: 10),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

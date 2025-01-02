import 'dart:io';
import 'package:flutter/material.dart';
import 'base_page.dart'; // Import BasePage
import 'fav_page.dart'; // Import FavouritePage

class PredictionPage extends StatelessWidget {
  final File image;
  final List<double> predictionScores;
  final String predictedDisease;
  final double highestScore;

  const PredictionPage({
    Key? key,
    required this.image,
    required this.predictionScores,
    required this.predictedDisease,
    required this.highestScore, required Null Function(dynamic index) onItemTapped, required int selectedIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Check if the confidence score is high enough
    bool isHighConfidence = highestScore >= 0.6;

    // Favourite button callback
    void addToFavorites() {
      // Check if the context is still valid before navigating
      if (context.mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FavouritePage(
              image: image,
              predictedDisease: predictedDisease,
              predictionDate: DateTime.now(), // Passing the current date
            ),
          ),
        );
      }
    }

    return BasePage(
      title: 'Prediction Result',
      selectedIndex: 1, // Set the selected index for bottom navigation (e.g., Scanner)
      onItemTapped: (int index) {
        // Handle bottom navigation item tap here if needed
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display the image that was used for prediction
              Image.file(image, height: 200, width: 200, fit: BoxFit.cover),
              const SizedBox(height: 20),

              // Display the result: either predicted disease or a warning message
              Text(
                isHighConfidence
                    ? 'Predicted Disease: $predictedDisease'
                    : 'Prediction Confidence Low',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: isHighConfidence ? Colors.green : Colors.red, // Color based on confidence
                ),
              ),
              const SizedBox(height: 20),

              // Show the confidence score
              Text(
                'Prediction Confidence: ${highestScore.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(height: 20),

              // Display more details (if needed) or options for further action
              ElevatedButton(
                onPressed: addToFavorites, // Call the function to add to favourites
                child: const Text('Add to Favourites'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey, // Button color
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

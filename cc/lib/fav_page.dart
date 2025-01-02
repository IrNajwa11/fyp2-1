import 'dart:io';
import 'package:flutter/material.dart';

class FavouritePage extends StatefulWidget {
  final File? image;
  final String? predictedDisease;
  final DateTime? predictionDate;

  // Constructor for displaying the page with data (favorite predictions)
  FavouritePage({
    Key? key,
    required this.image,
    required this.predictedDisease,
    required this.predictionDate,
  }) : super(key: key);

  // Constructor for the empty page (before the user adds any favorite prediction)
  FavouritePage.empty({Key? key})
      : image = null,
        predictedDisease = null,
        predictionDate = null,
        super(key: key);

  @override
  _FavouritePageState createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
      ),
      body: widget.image == null
          ? Center(
              child: const Text(
                'No favorites yet. Make a prediction to add it here!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 18),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Display the image
                  Image.file(widget.image!),
                  const SizedBox(height: 16),
                  // Display the predicted disease
                  Text(
                    'Predicted Disease: ${widget.predictedDisease}',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  // Display the prediction date
                  Text(
                    'Prediction Date: ${widget.predictionDate?.toLocal().toString().split(' ')[0]}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';
import 'base_page.dart'; // Import BasePage
import 'dInfoData.dart'; // Mock data import
import 'fav_page.dart'; // Import FavoritePage for navigation

class PredictionPage extends StatelessWidget {
  final File image;
  final List<double> predictionScores;
  final String predictedDisease;
  final double highestScore;

  static int idCounter = 0; // Static variable to track the ID for each prediction

  const PredictionPage({
    Key? key,
    required this.image,
    required this.predictionScores,
    required this.predictedDisease,
    required this.highestScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final diseaseInfo = DiseaseInfoData.diseaseList.firstWhere(
        (disease) => disease['label'] == predictedDisease);

    final TextStyle titleStyle = const TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold);
    final TextStyle bodyStyle = const TextStyle(fontSize: 22.0);

    final borderColor = predictedDisease.toLowerCase().contains('healthy')
        ? const Color(0xFF0A8484)
        : const Color(0xFFA7482E);

    final theme = Theme.of(context);
    final gradientColors = theme.brightness == Brightness.light
        ? [const Color(0xFF0A8484), Colors.white]
        : [const Color(0xFF0A8484), const Color(0xFF121212)];

    // Check if the disease is already in the favorites list
    final isFavorited = FavoritePage.favoriteList.any((favorite) =>
        favorite['disease'] == predictedDisease && favorite['image'] == image);

    return BasePage(
      title: 'Prediction Result',
      selectedIndex: 0,
      onItemTapped: (index) {
        if (index == 1) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => FavoritePage()),
          );
        }
      },
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: gradientColors,
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Image with a11y properties
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: borderColor, width: 4.0),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                          semanticLabel: 'Predicted disease image for $predictedDisease',
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text('Predicted Disease: $predictedDisease', style: titleStyle, semanticsLabel: 'Predicted Disease label: $predictedDisease'),
                    const SizedBox(height: 20),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Causal Agent: ',
                                  style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: diseaseInfo['causalAgent'],
                                  style: bodyStyle,
                                ),
                              ],
                            ),
                            semanticsLabel: 'Causal Agent: ${diseaseInfo['causalAgent']}',
                          ),
                          const SizedBox(height: 20),
                          Text(
                            'Treatment:',
                            style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                            semanticsLabel: 'Treatment label',
                          ),
                          const SizedBox(height: 10),
                          buildNumberedTreatment(
                            context,
                            diseaseInfo['treatment'] as String,
                            bodyStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Favorite Button and Label with a11y
                    Align(
                      alignment: Alignment.topRight,
                      child: Column(
                        children: [
                          IconButton(
                            iconSize: 36.0,
                            icon: Icon(
                              isFavorited ? Icons.favorite : Icons.favorite_border,
                              color: isFavorited ? Color(0xFFD03B80) : null,
                            ),
                            onPressed: () {
                              if (!isFavorited) {
                                final favorite = {
                                  'id': idCounter++,
                                  'image': image,
                                  'disease': predictedDisease,
                                  'date': DateTime.now().toString(),
                                };
                                FavoritePage.addFavorite(favorite);
                              }
                              // Refresh UI
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PredictionPage(
                                    image: image,
                                    predictionScores: predictionScores,
                                    predictedDisease: predictedDisease,
                                    highestScore: highestScore,
                                  ),
                                ),
                              );
                            },
                            tooltip: isFavorited ? 'Remove from favorites' : 'Add to favorites',
                          ),
                          Text('Favourite', style: bodyStyle, semanticsLabel: 'Favourite label'), // The "Favourite" label below the button
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildNumberedTreatment(
      BuildContext context, String treatmentText, TextStyle textStyle) {
    List<String> sentences = treatmentText.split('.');

    List<Widget> formattedSentences = [];
    for (int i = 0; i < sentences.length; i++) {
      if (sentences[i].isNotEmpty) {
        String sentence = sentences[i].trim();
        formattedSentences.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${i + 1}. ', style: textStyle),
              Expanded(
                child: Text(sentence, style: textStyle),
              ),
            ],
          ),
        );
      }
    }
    return Column(children: formattedSentences);
  }
}

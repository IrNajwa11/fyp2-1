import 'dart:io';
import 'package:flutter/material.dart';
import 'base_page.dart'; // Import BasePage
import 'dInfodata.dart'; // Import DiseaseInfoData

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
    required this.highestScore,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Find the disease data based on predicted disease label
    final diseaseInfo = DiseaseInfoData.diseaseList
        .firstWhere((disease) => disease['label'] == predictedDisease);

    // Define adjustable text styles
    final TextStyle titleStyle = TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    );
    final TextStyle bodyStyle = TextStyle(
      fontSize: 22.0,
    );

    // Determine border color for the image
    final borderColor = predictedDisease.toLowerCase().contains('healthy')
        ? const Color(0xFF0A8484)
        : const Color(0xFFBF5537);

    return BasePage(
      title: 'Prediction Result',
      selectedIndex: 0,
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              // Gradient body container
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0A8484), // Start color (can change)
                      Color.fromARGB(255, 36, 36, 36), // End color (can change)
                    ],
                    begin: Alignment.topCenter, // Gradient direction (can change)
                    end: Alignment.bottomCenter, // Gradient direction (can change)
                    stops: [0.000000000001, 1.0], // Optional: control the gradient transition
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display the image with border
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          image,
                          height: 200,
                          width: 200,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Display predicted disease name
                    Text(
                      'Predicted Disease: $predictedDisease',
                      style: titleStyle,
                    ),
                    const SizedBox(height: 20),
                    // Display causal agent and treatment info
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Causal Agent
                          Text.rich(
                            TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Causal Agent: ',
                                  style: bodyStyle.copyWith(
                                      fontWeight: FontWeight.bold),
                                ),
                                TextSpan(
                                  text: diseaseInfo['causalAgent'],
                                  style: bodyStyle,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Treatment
                          Text(
                            'Treatment:',
                            style: bodyStyle.copyWith(
                                fontWeight: FontWeight.bold),
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
    // Split treatment into sentences
    List<String> sentences = treatmentText.split('.');

    // List to hold all formatted sentences
    List<Widget> formattedSentences = [];

    // Loop through each sentence, adding numbering and indentation
    for (int i = 0; i < sentences.length; i++) {
      if (sentences[i].isNotEmpty) {
        String sentence = sentences[i].trim();
        formattedSentences.add(
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Numbering
              Text(
                '${i + 1}. ',
                style: textStyle,
              ),
              // Sentence
              Expanded(
                child: Text(
                  sentence,
                  style: textStyle,
                ),
              ),
            ],
          ),
        );
      }
    }

    return Column(children: formattedSentences);
  }
}
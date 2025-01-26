import 'dart:io';
import 'package:flutter/material.dart';
import 'base_page.dart'; // Import BasePage
import 'dInfodata.dart'; // Import DiseaseInfoData
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

class PredictionPage extends StatefulWidget {
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
  _PredictionPageState createState() => _PredictionPageState();
}

class _PredictionPageState extends State<PredictionPage> {
  bool isFavorite = false; // Flag to track whether the icon is clicked

  @override
  Widget build(BuildContext context) {
    final diseaseInfo = DiseaseInfoData.diseaseList
        .firstWhere((disease) => disease['label'] == widget.predictedDisease);

    final TextStyle titleStyle = TextStyle(
      fontSize: 26.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Arial', // Set font to Arial
    );
    final TextStyle bodyStyle = TextStyle(
      fontSize: 22.0,
      color: Colors.white70,
      fontFamily: 'Arial', // Set font to Arial
    );
    final TextStyle boldBodyStyle = TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: 'Arial', // Set font to Arial
    );

    final borderColor = widget.predictedDisease.toLowerCase().contains('healthy')
        ? const Color(0xFF0A8484)
        : const Color(0xFFBF5537);

    if (widget.highestScore < 0.65) {
      return BasePage(
        title: 'Prediction Result',
        selectedIndex: 0,
        onItemTapped: (index) {},
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30.0),  // Increased padding
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Red warning message with shadow and rounded corners
                Semantics(
                  label: 'Warning: Prediction accuracy is too low',
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius: BorderRadius.circular(20.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.3),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(25.0),  // Increased padding
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'WARNING ! \n\n Prediction accuracy is too low to display results.',
                          style: const TextStyle(fontSize: 22.0, color: Colors.white, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),  // Larger space between sections
                // Display the template with all info as '-'
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF0A8484),
                        Color.fromARGB(255, 36, 36, 36),
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        spreadRadius: 4,
                        blurRadius: 6,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(25.0),  // Increased padding
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Image placeholder with border and shadow
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 4.0),
                          borderRadius: BorderRadius.circular(10.0),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 8.0,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.file(
                            widget.image,
                            height: 220,  // Increased image size
                            width: 220,  // Increased image size
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),  // Larger space between image and text
                      // Display predicted disease name with placeholder '-'
                      Semantics(
                        label: 'Predicted Disease: No prediction',
                        child: Text(
                          'Predicted Disease: No prediction',
                          style: titleStyle,
                        ),
                      ),
                      const SizedBox(height: 30),  // Larger space between sections
                      // Display causal agent and treatment as '-'
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Semantics(
                              label: 'Causal Agent: No Info',
                              child: Text.rich(
                                TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Causal Agent: ',
                                      style: boldBodyStyle,
                                    ),
                                    TextSpan(
                                      text: 'No Info',
                                      style: bodyStyle,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 30),  // Larger space between sections
                            Text(
                              'Treatment:',
                              style: boldBodyStyle,
                            ),
                            const SizedBox(height: 20),  // Larger space between treatment title and items
                            buildNumberedTreatment(
                              context,
                              'No Info',
                              bodyStyle,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),  // Larger space before the Favorite Button
                // Favorite Button
                GestureDetector(
                  onTap: isFavorite ? null : () async {
                    setState(() {
                      isFavorite = true; // Once clicked, mark as favorite and disable further clicks
                    });

                    final prefs = await SharedPreferences.getInstance();
                    final favoriteData = {
                      'imagePath': widget.image.path,
                      'disease': widget.predictedDisease,
                      'date': DateTime.now().toString(),
                    };
                    List<String> favorites = prefs.getStringList('favorites') ?? [];
                    favorites.add(favoriteData.toString());
                    await prefs.setStringList('favorites', favorites);
                  },
                  child: Column(
                    children: [
                      Icon(
                        isFavorite ? Icons.favorite : Icons.favorite_border,
                        color: isFavorite ? Color(0xFFD03B80) : Colors.white, // Filled icon when clicked
                        size: 45.0,  // Increased icon size
                      ),
                      const SizedBox(height: 10),  // Larger space between icon and text
                      Text(
                        'Favourite',
                        style: TextStyle(color: Colors.white),
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

    return BasePage(
      title: 'Prediction Result',
      selectedIndex: 0,
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),  // Increased padding
          child: Column(
            children: [
              // Gradient body container with shadow
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      const Color(0xFF0A8484),
                      Color.fromARGB(255, 36, 36, 36),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.000000000001, 1.0],
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      spreadRadius: 4,
                      blurRadius: 6,
                      offset: Offset(0, 4),
                    ),
                  ],
                ),
                padding: const EdgeInsets.all(25.0),  // Increased padding
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display the image with border and shadow
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: borderColor,
                          width: 4.0,
                        ),
                        borderRadius: BorderRadius.circular(10.0),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 8.0,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.file(
                          widget.image,
                          height: 220,  // Increased image size
                          width: 220,  // Increased image size
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),  // Larger space between image and text
                    // Display predicted disease name
                    Semantics(
                      label: 'Predicted Disease: ${widget.predictedDisease}',
                      child: Text(
                        'Predicted Disease: ${widget.predictedDisease}',
                        style: titleStyle,
                      ),
                    ),
                    const SizedBox(height: 30),  // Larger space between sections
                    // Display causal agent and treatment info
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Causal Agent
                          Semantics(
                            label: 'Causal Agent: ${diseaseInfo['causalAgent']}',
                            child: Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                    text: 'Causal Agent: ',
                                    style: boldBodyStyle,
                                  ),
                                  TextSpan(
                                    text: diseaseInfo['causalAgent'],
                                    style: bodyStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 30),  // Larger space between sections
                          // Treatment
                          Text(
                            'Treatment:',
                            style: boldBodyStyle,
                          ),
                          const SizedBox(height: 20),  // Larger space between treatment title and items
                          buildNumberedTreatment(
                            context,
                            diseaseInfo['treatment'] as String,
                            bodyStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),  // Larger space before the Favorite Button
                    // Favorite Button
                    GestureDetector(
                      onTap: isFavorite ? null : () async {
                        setState(() {
                          isFavorite = true; // Once clicked, mark as favorite and disable further clicks
                        });

                        final prefs = await SharedPreferences.getInstance();
                        final favoriteData = {
                          'imagePath': widget.image.path,
                          'disease': widget.predictedDisease,
                          'date': DateTime.now().toString(),
                        };
                        List<String> favorites = prefs.getStringList('favorites') ?? [];
                        favorites.add(favoriteData.toString());
                        await prefs.setStringList('favorites', favorites);
                      },
                      child: Column(
                        children: [
                          Icon(
                            isFavorite ? Icons.favorite : Icons.favorite_border,
                            color: isFavorite ? Color(0xFFD03B80) : Colors.white, // Filled icon when clicked
                            size: 60.0,  // Increased icon size
                          ),
                          const SizedBox(height: 10),  // Larger space between icon and text
                          Text(
                            'Favourite',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0, // Increased font size
                            ),
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

  Widget buildNumberedTreatment(BuildContext context, String treatment, TextStyle style) {
  final treatmentList = treatment.split('\n');
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: List.generate(
      treatmentList.length,
      (index) => Column(
        children: [
          Text(
            '${index + 1}. ${treatmentList[index]}',
            style: style,
          ),
          const SizedBox(height: 15),  // Increased space between each treatment item
        ],
      ),
    ),
  );
}
}
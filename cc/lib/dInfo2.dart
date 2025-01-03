import 'package:flutter/material.dart';
import 'dInfoD.dart';
import 'disease.dart'; // Import the Disease class
import 'base_page.dart'; // Import BasePage

class DiseaseInfoPage2 extends StatelessWidget {
  final Disease disease;

  DiseaseInfoPage2({required this.disease});

  @override
  Widget build(BuildContext context) {
    final diseaseInfo = dinfo[disease.name] ?? {};

    // Define adjustable text styles
    final TextStyle titleStyle = TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
    );
    final TextStyle bodyStyle = TextStyle(
      fontSize: 22.0,
    );

    // Fixed border color for the disease image
    final borderColor = const Color(0xFFBF5537);

    return BasePage(
      title: 'Disease Information',
      selectedIndex: 0,
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Center the image above the gradient container
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
                  child: Image.asset(
                    disease.imagePath,
                    height: 150,
                    width: 200,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(height: 20), // Space between the image and the gradient container

              // Gradient container below the image that takes full screen width
              Container(
                width: double.infinity, // Full width
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 139, 60, 39), // Red color
                      const Color(0xFF242424), // Black color
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.02, 1], // Red only for the top 2% of the space
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 60.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      diseaseInfo['label'] ?? 'Unknown Disease',
                      style: titleStyle,
                    ),
                    const SizedBox(height: 20),
                    // Disease details
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Type: ',
                            style: bodyStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: diseaseInfo['type'] ?? 'Unknown',
                            style: bodyStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Causal Agent: ',
                            style: bodyStyle.copyWith(
                                fontWeight: FontWeight.bold),
                          ),
                          TextSpan(
                            text: diseaseInfo['causalAgent'] ?? 'Unknown',
                            style: bodyStyle,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Symptoms display
                    Text(
                      'Symptoms:',
                      style: bodyStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Iterate over the categories of symptoms (Leaves, Stems, Vegetable)
                        ...((diseaseInfo['symptoms'] as Map<String, List<String>>?)?.entries.map((entry) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${entry.key}:',
                                  style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
                                ),
                                const SizedBox(height: 5),
                                ...entry.value.map((symptom) {
                                  return Text(
                                    symptom,
                                    style: bodyStyle,
                                  );
                                }).toList(),
                              ],
                            ),
                          );
                        }) ?? []),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Optimum Conditions display
                    Text(
                      'Optimum Conditions:',
                      style: bodyStyle.copyWith(
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display optimum conditions
                        Text(
                          'Temperature: ${diseaseInfo['optimumConditions']?['Temperature'] ?? 'Unknown'}',
                          style: bodyStyle,
                        ),
                        Text(
                          'Humidity: ${diseaseInfo['optimumConditions']?['Humidity'] ?? 'Unknown'}',
                          style: bodyStyle,
                        ),
                        Text(
                          'Soil: ${diseaseInfo['optimumConditions']?['Soil'] ?? 'Unknown'}',
                          style: bodyStyle,
                        ),
                      ],
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
}

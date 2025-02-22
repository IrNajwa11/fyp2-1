import 'package:flutter/material.dart';
import 'dInfoD.dart';
import 'disease.dart';
import 'base_page.dart';

class DiseaseInfoPage2 extends StatelessWidget {
  final Disease disease;

  DiseaseInfoPage2({required this.disease});

  @override
  Widget build(BuildContext context) {
    final diseaseInfo = dinfo[disease.name] ?? {};

    final TextStyle titleStyle = TextStyle(
      fontSize: 25.0,
      fontWeight: FontWeight.bold,
      fontFamily: 'Arial',
    );
    final TextStyle bodyStyle = TextStyle(
      fontSize: 22.0,
      height: 1.5,
      fontFamily: 'Arial',
    );

    final borderColor = Color(0xFFBB593E);
    final isLightMode = Theme.of(context).brightness == Brightness.light;
    final containerGradient = LinearGradient(
      colors: isLightMode
          ? [Color(0xFFBB593E), Color.fromARGB(255, 235, 220, 220)]
          : [Color(0xFFBB593E), const Color(0xFF242424)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      stops: [0.02, 1],
    );

    return BasePage(
      title: 'Disease Information',
      selectedIndex: 0,
      onItemTapped: (index) {},
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: borderColor, width: 5.0),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    child: Image.asset(
                      disease.imagePath,
                      height: 150,
                      width: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: containerGradient,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 40.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Semantics(
                        label: diseaseInfo['label'] ?? 'Unknown Disease',
                        child: Text(
                          diseaseInfo['label'] ?? 'Unknown Disease',
                          style: titleStyle,
                        ),
                      ),
                      const SizedBox(height: 20),
                      buildRichText(
                          'Type', diseaseInfo['type'] ?? 'Unknown', bodyStyle),
                      const SizedBox(height: 20),
                      buildRichText('Causal Agent',
                          diseaseInfo['causalAgent'] ?? 'Unknown', bodyStyle),
                      const SizedBox(height: 20),
                      Semantics(
                        label: 'Symptoms:',
                        child: Text(
                          'Symptoms:',
                          style: titleStyle.copyWith(fontSize: 22),
                        ),
                      ),
                      const SizedBox(height: 10),
                      ...buildNumberedSymptomSections(
                          diseaseInfo['symptoms'], bodyStyle),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildRichText(String title, String content, TextStyle bodyStyle) {
    return Semantics(
      label: '$title: $content',
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(
              text: '$title: ',
              style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
            ),
            TextSpan(
              text: content,
              style: bodyStyle,
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> buildNumberedSymptomSections(
      Map<String, List<String>>? symptoms, TextStyle bodyStyle) {
    if (symptoms == null) return [];

    return symptoms.entries.map((entry) {
      final part = entry.key;
      final items = entry.value;

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: 'Symptom part: $part',
              child: Text(
                part,
                style: bodyStyle.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 5),
            ...buildNumberedList(items, bodyStyle),
          ],
        ),
      );
    }).toList();
  }

  List<Widget> buildNumberedList(List<String> items, TextStyle bodyStyle) {
    return items.asMap().entries.map((entry) {
      final index = entry.key;
      final symptom = entry.value;

      return Padding(
        padding: const EdgeInsets.only(left: 20.0, top: 5.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Semantics(
              label: 'Symptom number ${index + 1} is: $symptom',
              child: Text(
                '${index + 1}. ',
                style: bodyStyle,
              ),
            ),
            Expanded(
              child: Semantics(
                label: 'Symptom description: $symptom',
                child: Text(
                  symptom,
                  style: bodyStyle,
                  textAlign: TextAlign.left,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

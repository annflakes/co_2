import 'package:flutter/material.dart';
import 'dart:math';

class ColorNamingPracticePage extends StatefulWidget {
  @override
  _ColorNamingPracticePageState createState() =>
      _ColorNamingPracticePageState();
}

class _ColorNamingPracticePageState extends State<ColorNamingPracticePage> {
  final List<Map<String, Color>> colorOptions = [
    {'Red': Colors.red},
    {'Blue': Colors.blue},
    {'Green': Colors.green},
    {'Yellow': Colors.yellow},
    {'Purple': Colors.purple},
    {'Orange': Colors.orange},
    {'Pink': Colors.pink},
    {'Brown': Colors.brown},
  ];

  late Map<String, Color> currentColor;
  late List<String> currentOptions;
  String? feedbackMessage;

  @override
  void initState() {
    super.initState();
    generateNewQuestion();
  }

  void generateNewQuestion() {
    final random = Random();
    currentColor = colorOptions[random.nextInt(colorOptions.length)];
    currentOptions = colorOptions
        .map((option) => option.keys.first)
        .toList()
      ..shuffle();
    feedbackMessage = null;
  }

  void checkAnswer(String selectedColorName) {
    if (currentColor.keys.first == selectedColorName) {
      setState(() {
        feedbackMessage = "Correct! It's ${currentColor.keys.first}. 🎉";
      });
    } else {
      setState(() {
        feedbackMessage =
            "Wrong! It's actually ${currentColor.keys.first}. Try again.";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Color Naming Practice'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Identify the Color!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Container(
              height: 150,
              color: currentColor.values.first,
            ),
            SizedBox(height: 20),
            ...currentOptions.map((option) {
              return ElevatedButton(
                onPressed: () => checkAnswer(option),
                child: Text(option),
              );
            }).toList(),
            if (feedbackMessage != null) ...[
              SizedBox(height: 20),
              Text(
                feedbackMessage!,
                style: TextStyle(
                  fontSize: 18,
                  color: feedbackMessage!.contains('Correct')
                      ? Colors.green
                      : Colors.red,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    generateNewQuestion();
                  });
                },
                child: Text('Next Color'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
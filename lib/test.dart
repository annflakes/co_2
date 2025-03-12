import 'package:flutter/material.dart';
import 'database/database_helper.dart'; // Import your database helper
import 'models/test_result.dart'; // Import your TestResult model

class ColorBlindnessTestPage extends StatefulWidget {
  const ColorBlindnessTestPage({super.key});

  @override
  _ColorBlindnessTestPageState createState() => _ColorBlindnessTestPageState();
}

class _ColorBlindnessTestPageState extends State<ColorBlindnessTestPage> {
  int currentQuestionIndex = 0;
  int score = 0;

  final List<Map<String, dynamic>> questions = [
    {
      'image': 'assets/Ishihara-Plate-01-38.jpg', // Add Ishihara test images in assets folder
      'options': ['12', '6', '9', 'Nothing'],
      'answer': '12',
    },
    {
      'image': 'assets/Ishihara_03.jpg',
      'options': ['18', '13', '16', 'Nothing'],
      'answer': '16',
    },
    {
      'image': 'assets/ishihara_45.jpg',
      'options': ['56', '45', 'Nothing', '65'],
      'answer': '45',
    },
    {
      'image': 'assets/kids-color-blind-test-06.jpg',
      'options': ['Kangaroo', 'Donkey', 'Nothing', 'Elephant'],
      'answer': 'Elephant',
    },
    {
      'image': 'assets/butterfly.jpg',
      'options': ['Bird', 'Butterfly', 'Nothing', 'Bee'],
      'answer': 'Butterfly',
    },
    {
      'image': 'assets/giraffe.jpg',
      'options': ['Giraffe', 'Horse', 'Donkey', 'Nothing'],
      'answer': 'Giraffe',
    },
    {
      'image': 'assets/triangle.jpg',
      'options': ['Square', 'Rectangle', 'Triangle', 'Nothing'],
      'answer': 'Triangle',
    },
    {
      'image': 'assets/circle.jpg',
      'options': ['Pentagon', 'Circle', 'Square', 'Nothing'],
      'answer': 'Circle',
    },
    {
      'image': 'assets/rhombus.jpg',
      'options': ['Circle', 'Rhombus', 'Hexagon', 'Nothing'],
      'answer': 'Rhombus',
    },
    {
      'image': 'assets/Z_image.jpg',
      'options': ['X', 'Y', 'Nothing', 'Z'],
      'answer': 'Z',
    },
    {
      'image': 'assets/B_image.jpg',
      'options': ['R', 'B', 'Nothing', 'P'],
      'answer': 'B',
    },
    {
      'image': 'assets/k_image.jpg',
      'options': ['R', 'K', 'Nothing', 'L'],
      'answer': 'K',
    },
  ];

  void checkAnswer(String selectedOption) {
    if (selectedOption == questions[currentQuestionIndex]['answer']) {
      score++;
    }
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      showResult();
    }
  }

  void saveTestResult(String diagnosis) async {
    // Create a TestResult object
    final result = TestResult(
      testType: 'Color Blindness Test', // Customize test type if needed
      correctAnswers: score,
      incorrectAnswers: questions.length - score,
      diagnosis: diagnosis,
      date: DateTime.now(),
    );

    // Save the result to the database
    await DatabaseHelper().insertResult(result);

    // Show a confirmation message
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Test result saved successfully!')),
    );
  }

  void showResult() {
    String diagnosis;
    if (score == questions.length) {
      diagnosis = 'Normal Vision';
    } else if (score == 0) {
      diagnosis = 'Severe Color Blindness';
    } else if (score <= (questions.length / 2).ceil()) {
      diagnosis = 'Moderate Color Blindness';
    } else {
      diagnosis = 'Mild Color Blindness';
    }

    // Save the test result
    saveTestResult(diagnosis);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Test Completed'),
        content: Text(
          'You answered $score out of ${questions.length} questions correctly.\nDiagnosis: $diagnosis',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Return to the homepage
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[currentQuestionIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('Color Blindness Test'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Question ${currentQuestionIndex + 1} of ${questions.length}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.asset(
              currentQuestion['image'],
              height: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            ...currentQuestion['options'].map((option) {
              return ElevatedButton(
                onPressed: () => checkAnswer(option),
                child: Text(option),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}

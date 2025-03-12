import 'package:flutter/material.dart';
import 'database/database_helper.dart';
import 'models/test_result.dart';
import 'package:co_2/chart.dart'; // Ensure this points to your ProgressChartPage file

class HistoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History & Progress'),
      ),
      body: FutureBuilder<List<TestResult>>(
        future: DatabaseHelper().getResults(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final results = snapshot.data!;
          if (results.isEmpty) {
            return Center(child: Text('No test results found.'));
          }
          return Column(
            children: [
              // ElevatedButton for navigating to the Progress Chart Page
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProgressChartPage(), // Ensure ProgressChartPage is implemented
                      ),
                    );
                  },
                  child: Text('View Progress Chart'),
                ),
              ),
              // List of Test Results
              Expanded(
                child: ListView.builder(
                  itemCount: results.length,
                  itemBuilder: (context, index) {
                    final result = results[index];
                    return ListTile(
                      title: Text(result.testType),
                      subtitle: Text(
                        'Correct: ${result.correctAnswers}, Incorrect: ${result.incorrectAnswers}\nDiagnosis: ${result.diagnosis}\nDate: ${result.date.toLocal()}',
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

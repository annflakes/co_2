import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'database/database_helper.dart';
import 'models/test_result.dart';

class ProgressChartPage extends StatelessWidget {
  const ProgressChartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Progress Chart'),
      ),
      body: FutureBuilder<List<TestResult>>(
        future: DatabaseHelper().getResults(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final results = snapshot.data!;
          if (results.isEmpty) {
            return Center(child: Text('No data available.'));
          }

          // Prepare data for the chart
          final barGroups = results
              .asMap()
              .entries
              .map((entry) {
                final index = entry.key;
                final result = entry.value;
                return BarChartGroupData(
                  x: index,
                  barRods: [
                    BarChartRodData(
                      toY: result.correctAnswers.toDouble(),
                      color: Colors.green,
                      width: 16,
                    ),
                    BarChartRodData(
                      toY: result.incorrectAnswers.toDouble(),
                      color: Colors.red,
                      width: 16,
                    ),
                  ],
                );
              })
              .toList();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: BarChart(
              BarChartData(
                barGroups: barGroups,
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: true),
                  ),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index >= 0 && index < results.length) {
                          return Text(
                            results[index].testType,
                            style: TextStyle(fontSize: 10),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(show: false),
                gridData: FlGridData(show: false),
              ),
            ),
          );
        },
      ),
    );
  }
}
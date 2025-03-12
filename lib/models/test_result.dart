class TestResult {
  final String testType;
  final int correctAnswers;
  final int incorrectAnswers;
  final String diagnosis;
  final DateTime date;

  TestResult({
    required this.testType,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.diagnosis,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'testType': testType,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'diagnosis': diagnosis,
      'date': date.toIso8601String(),
    };
  }

  static TestResult fromMap(Map<String, dynamic> map) {
    return TestResult(
      testType: map['testType'],
      correctAnswers: map['correctAnswers'],
      incorrectAnswers: map['incorrectAnswers'],
      diagnosis: map['diagnosis'],
      date: DateTime.parse(map['date']),
    );
  }
}

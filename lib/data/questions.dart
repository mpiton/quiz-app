import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:quiz_app/models/question.dart';

Future<List<Question>> getQuestions() async {
  final response =
      await http.get(Uri.parse('https://opentdb.com/api.php?amount=10'));
  if (response.statusCode == 200) {
    final Map<String, dynamic> data = json.decode(response.body);
    final List<Question> questions = [];
    for (final Map<String, dynamic> question in data['results']) {
      questions.add(
        Question(
          text: question['question'],
          answers: List<String>.from(question['incorrect_answers'])
            ..add(
              question['correct_answer'],
            ),
          correctAnswer: question['correct_answer'],
        ),
      );
    }
    return questions;
  } else {
    throw Exception(
        'Failed to load questions ${response.statusCode} - ${response.body}');
  }
}

import 'package:flutter/material.dart';
import 'package:quiz_app/models/question.dart';
import 'package:quiz_app/questions_screen.dart';
import 'package:quiz_app/results_screen.dart';
import 'package:quiz_app/start_screen.dart';

class Quiz extends StatefulWidget {
  const Quiz({super.key});

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  final List<String> selectedAnswers = [];
  final List<Question> questions = [];
  String activeScreen = 'start'; // 'start' or 'questions

  void switchScreen() {
    setState(() {
      activeScreen = activeScreen == 'start' ? 'questions' : 'start';
    });
  }

  void chooseAnswer(String answer, Question question) {
    selectedAnswers.add(answer);
    questions.add(question);

    if (selectedAnswers.length == 10) {
      setState(() {
        activeScreen = 'results';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget screen;
    if (activeScreen == 'start') {
      setState(() {
        selectedAnswers.clear();
      });
      screen = StartScreen(switchScreen);
    } else if (activeScreen == 'questions') {
      screen = QuestionsScreen(onSelectAnswer: chooseAnswer);
    } else {
      screen =
          ResultsScreen(chosenAnswers: selectedAnswers, questions: questions);
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      home: Scaffold(
          body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: screen,
      )),
    );
  }
}

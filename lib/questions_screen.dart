import 'package:flutter/material.dart';
import 'package:quiz_app/answer_button.dart';
import 'package:quiz_app/data/questions.dart';
import 'package:quiz_app/models/question.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key, required this.onSelectAnswer});

  final void Function(String answer, Question question) onSelectAnswer;

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {
  int currentQuestionIndex = 0;
  List<Question> questions = [];
  answerQuestion(String answer, Question question) {
    widget.onSelectAnswer(answer, question);
    setState(() {
      currentQuestionIndex++;
    });
  }

  fetchQuestions() async {
    final List<Question> fetchedQuestions = await getQuestions();
    setState(() {
      questions = fetchedQuestions;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (questions.isEmpty) {
      fetchQuestions();
    }

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.deepPurple, Colors.blue],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: questions.isEmpty
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _buildQuestions(questions),
      ),
    );
  }

  Widget _buildQuestions(List<Question> questions) {
    final HtmlUnescape unescape = HtmlUnescape();
    Question currentQuestion = questions[currentQuestionIndex];

    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            unescape.convert(currentQuestion.text),
            textAlign: TextAlign.center,
            style: GoogleFonts.lato(
              fontSize: 20,
              color: Colors.white,
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          ...currentQuestion.getShuffledAnswers().map((String answer) {
            return AnswerButton(
              answerText: answer,
              onTap: () =>
                  answerQuestion(answer, questions[currentQuestionIndex]),
            );
          }),
        ],
      ),
    );
  }
}

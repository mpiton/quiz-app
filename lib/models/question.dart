class Question {
  const Question({
    required this.text,
    required this.answers,
    required this.correctAnswer,
  });

  final String text;
  final List<String> answers;
  final String correctAnswer;

  List<String> getShuffledAnswers() {
    final List<String> shuffledAnswers = List.from(answers)..shuffle();
    return shuffledAnswers;
  }
}

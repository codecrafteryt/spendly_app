class QuizOption {
  const QuizOption({
    required this.text,
    required this.score,
    required this.category,
  });

  final String text;
  final int score;
  final String category;
}

class QuizQuestion {
  const QuizQuestion({
    required this.id,
    required this.questionText,
    required this.options,
  });

  final String id;
  final String questionText;
  final List<QuizOption> options;
}

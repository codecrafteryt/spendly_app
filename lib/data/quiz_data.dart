import 'package:spendly_app/data/models/quiz_model/quiz_question.dart';
import 'package:spendly_app/data/models/quiz_model/spender_type.dart';

List<QuizQuestion> getQuizQuestions() => const [
  QuizQuestion(
    id: 'q1',
    questionText: 'How often do you buy something unplanned?',
    options: [
      QuizOption(text: 'Almost daily', score: 5, category: ScoreCategories.impulse),
      QuizOption(text: 'A few times a week', score: 4, category: ScoreCategories.impulse),
      QuizOption(text: 'Once a week', score: 2, category: ScoreCategories.impulse),
      QuizOption(text: 'Rarely', score: 0, category: ScoreCategories.impulse),
    ],
  ),
  QuizQuestion(
    id: 'q2',
    questionText: 'Do you follow a monthly budget?',
    options: [
      QuizOption(text: 'Never', score: 0, category: ScoreCategories.planning),
      QuizOption(text: 'Sometimes', score: 2, category: ScoreCategories.planning),
      QuizOption(text: 'Most months', score: 4, category: ScoreCategories.planning),
      QuizOption(text: 'Always', score: 5, category: ScoreCategories.planning),
    ],
  ),
  QuizQuestion(
    id: 'q3',
    questionText: 'How consistent is your savings habit?',
    options: [
      QuizOption(text: 'I rarely save', score: 0, category: ScoreCategories.savings),
      QuizOption(text: 'Occasionally', score: 2, category: ScoreCategories.savings),
      QuizOption(text: 'Most months', score: 4, category: ScoreCategories.savings),
      QuizOption(text: 'Every paycheck', score: 5, category: ScoreCategories.savings),
    ],
  ),
  QuizQuestion(
    id: 'q4',
    questionText: 'How well do you track subscriptions?',
    options: [
      QuizOption(text: 'Not at all', score: 0, category: ScoreCategories.awareness),
      QuizOption(text: 'Vaguely', score: 2, category: ScoreCategories.awareness),
      QuizOption(text: 'I review quarterly', score: 4, category: ScoreCategories.awareness),
      QuizOption(text: 'I know every charge', score: 5, category: ScoreCategories.awareness),
    ],
  ),
  QuizQuestion(
    id: 'q5',
    questionText: 'When stressed, do you spend to feel better?',
    options: [
      QuizOption(text: 'Often', score: 5, category: ScoreCategories.impulse),
      QuizOption(text: 'Sometimes', score: 3, category: ScoreCategories.impulse),
      QuizOption(text: 'Rarely', score: 1, category: ScoreCategories.impulse),
      QuizOption(text: 'Never', score: 0, category: ScoreCategories.impulse),
    ],
  ),
  QuizQuestion(
    id: 'q6',
    questionText: 'How often do you check income vs expenses?',
    options: [
      QuizOption(text: 'Never', score: 0, category: ScoreCategories.awareness),
      QuizOption(text: 'Once a year', score: 1, category: ScoreCategories.awareness),
      QuizOption(text: 'Monthly', score: 4, category: ScoreCategories.awareness),
      QuizOption(text: 'Weekly', score: 5, category: ScoreCategories.awareness),
    ],
  ),
  QuizQuestion(
    id: 'q7',
    questionText: 'Before a big purchase, you typically...',
    options: [
      QuizOption(text: 'Buy immediately', score: 5, category: ScoreCategories.impulse),
      QuizOption(text: 'Think briefly', score: 3, category: ScoreCategories.planning),
      QuizOption(text: 'Research and compare', score: 4, category: ScoreCategories.planning),
      QuizOption(text: 'Wait and budget for it', score: 5, category: ScoreCategories.planning),
    ],
  ),
  QuizQuestion(
    id: 'q8',
    questionText: 'Your emergency fund covers...',
    options: [
      QuizOption(text: 'Nothing saved', score: 0, category: ScoreCategories.savings),
      QuizOption(text: 'Less than 1 month', score: 2, category: ScoreCategories.savings),
      QuizOption(text: '1–3 months', score: 4, category: ScoreCategories.savings),
      QuizOption(text: '3+ months', score: 5, category: ScoreCategories.savings),
    ],
  ),
  QuizQuestion(
    id: 'q9',
    questionText: 'How do you feel about money conversations?',
    options: [
      QuizOption(text: 'Very anxious', score: 5, category: ScoreCategories.awareness),
      QuizOption(text: 'Uncomfortable', score: 3, category: ScoreCategories.awareness),
      QuizOption(text: 'Neutral', score: 2, category: ScoreCategories.planning),
      QuizOption(text: 'Confident', score: 0, category: ScoreCategories.planning),
    ],
  ),
  QuizQuestion(
    id: 'q10',
    questionText: 'Sale alerts make you...',
    options: [
      QuizOption(text: 'Buy right away', score: 5, category: ScoreCategories.impulse),
      QuizOption(text: 'Browse and often buy', score: 4, category: ScoreCategories.impulse),
      QuizOption(text: 'Add to wishlist', score: 2, category: ScoreCategories.planning),
      QuizOption(text: 'Ignore them', score: 0, category: ScoreCategories.planning),
    ],
  ),
];

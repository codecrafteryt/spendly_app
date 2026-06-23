import 'package:cloud_functions/cloud_functions.dart';
import 'package:spendly_app/core/utils/firebase_initializer.dart';
import 'package:spendly_app/data/models/quiz_model/spender_type.dart';

class AiService {
  AiService({FirebaseFunctions? functions}) : _functions = functions;

  final FirebaseFunctions? _functions;

  Future<String> generateReport({
    required SpenderType spenderType,
    required Map<String, int> scores,
    required Map<String, String> answers,
  }) async {
    if (isFirebaseReady && _functions != null) {
      try {
        final text = await _fetchFromCloud(
          spenderType: spenderType,
          scores: scores,
          answers: answers,
        );
        if (text.isNotEmpty) return text;
      } catch (_) {
        // Fall back to offline report when cloud is unavailable.
      }
    }
    return _offlineReport(
      spenderType: spenderType,
      scores: scores,
      answers: answers,
    );
  }

  Future<String> _fetchFromCloud({
    required SpenderType spenderType,
    required Map<String, int> scores,
    required Map<String, String> answers,
  }) async {
    final callable = _functions!.httpsCallable('generateReport');
    final result = await callable.call<Map<String, dynamic>>({
      'spenderType': spenderType.label,
      'scores': scores,
      'answers': answers,
    });
    final text = result.data['reportText'] as String?;
    if (text == null || text.isEmpty) {
      throw Exception('Empty report from server');
    }
    return text;
  }

  String _offlineReport({
    required SpenderType spenderType,
    required Map<String, int> scores,
    required Map<String, String> answers,
  }) {
    final impulse = scores[ScoreCategories.impulse] ?? 0;
    final planning = scores[ScoreCategories.planning] ?? 0;
    final savings = scores[ScoreCategories.savings] ?? 0;
    final awareness = scores[ScoreCategories.awareness] ?? 0;

    final typeInsight = switch (spenderType) {
      SpenderType.impulsiveSpender =>
        'You tend to spend quickly when something catches your eye. '
            'Small daily purchases add up faster than you expect.',
      SpenderType.anxiousAvoider =>
        'Money feels stressful, so you sometimes avoid checking accounts. '
            'Awareness is your first step toward calm, steady progress.',
      SpenderType.cautiousPlanner =>
        'You think before you spend and prefer structure. '
            'Your next win is turning plans into automated habits.',
      SpenderType.confidentSaver =>
        'You save consistently and stay aware of your finances. '
            'Fine-tune subscriptions and big purchases to optimize further.',
    };

    return '''
Your Spender Type: ${spenderType.label}

$typeInsight

Score Snapshot
• Impulse: $impulse
• Planning: $planning
• Savings: $savings
• Awareness: $awareness

Top Recommendations
1. Pick one category to track daily for the next 7 days.
2. Set a small weekly savings transfer — even a little builds momentum.
3. Review recurring charges once this month and cancel one you rarely use.

This is a preview report generated offline. Connect Firebase for AI-personalized insights based on your full quiz answers (${answers.length} responses).
''';
  }
}

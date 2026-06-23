import 'package:spendly_app/data/models/quiz_model/quiz_question.dart';
import 'package:spendly_app/data/models/quiz_model/spender_type.dart';

Map<String, int> aggregateScores(List<QuizOption> answers) {
  final scores = {for (final c in ScoreCategories.all) c: 0};
  for (final option in answers) {
    scores[option.category] = (scores[option.category] ?? 0) + option.score;
  }
  return scores;
}

SpenderType calculateSpenderType(Map<String, int> scores) {
  final impulse = scores[ScoreCategories.impulse] ?? 0;
  final planning = scores[ScoreCategories.planning] ?? 0;
  final savings = scores[ScoreCategories.savings] ?? 0;
  final awareness = scores[ScoreCategories.awareness] ?? 0;

  if (impulse >= planning && impulse >= savings && impulse >= awareness) {
    return SpenderType.impulsiveSpender;
  }

  if (savings >= planning &&
      savings >= awareness &&
      savings >= impulse &&
      impulse <= savings - 5) {
    return SpenderType.confidentSaver;
  }

  if (awareness >= impulse &&
      awareness >= savings &&
      awareness > planning &&
      savings <= awareness - 5) {
    return SpenderType.anxiousAvoider;
  }

  return SpenderType.cautiousPlanner;
}

String freePreviewTip(SpenderType type) {
  switch (type) {
    case SpenderType.impulsiveSpender:
      return 'Try a 24-hour rule before non-essential purchases to cut impulse buys.';
    case SpenderType.anxiousAvoider:
      return 'Schedule a 10-minute weekly money check-in to reduce anxiety over time.';
    case SpenderType.cautiousPlanner:
      return 'You plan well — automate savings so good intentions always turn into action.';
    case SpenderType.confidentSaver:
      return 'Great savings habits — review one subscription this month to optimize further.';
  }
}

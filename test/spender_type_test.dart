import 'package:flutter_test/flutter_test.dart';
import 'package:spendly_app/features/quiz/logic/spender_type_calculator.dart';
import 'package:spendly_app/data/models/quiz_model/spender_type.dart';

void main() {
  test('calculateSpenderType returns impulsive for high impulse', () {
    final type = calculateSpenderType({
      ScoreCategories.impulse: 22,
      ScoreCategories.planning: 8,
      ScoreCategories.savings: 10,
      ScoreCategories.awareness: 12,
    });
    expect(type, SpenderType.impulsiveSpender);
  });

  test('calculateSpenderType returns confident saver', () {
    final type = calculateSpenderType({
      ScoreCategories.impulse: 10,
      ScoreCategories.planning: 14,
      ScoreCategories.savings: 20,
      ScoreCategories.awareness: 18,
    });
    expect(type, SpenderType.confidentSaver);
  });
}

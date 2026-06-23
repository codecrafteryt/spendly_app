enum SpenderType {
  impulsiveSpender('Impulsive Spender'),
  anxiousAvoider('Anxious Avoider'),
  cautiousPlanner('Cautious Planner'),
  confidentSaver('Confident Saver');

  const SpenderType(this.label);
  final String label;
}

class ScoreCategories {
  ScoreCategories._();
  static const impulse = 'impulseScore';
  static const planning = 'planningScore';
  static const savings = 'savingsScore';
  static const awareness = 'awarenessScore';

  static const all = [impulse, planning, savings, awareness];
}

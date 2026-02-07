class CaffeineDecision {
  final bool drinkCoffee;

  CaffeineDecision(this.drinkCoffee);

  factory CaffeineDecision.fromVitals(Map<String, dynamic> vitals) {
    final heartRate = vitals["heartRate"] ?? 0;
    return CaffeineDecision(heartRate < 90);
  }
}

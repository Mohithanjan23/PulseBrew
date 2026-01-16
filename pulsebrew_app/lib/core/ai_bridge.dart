import 'health_bridge.dart';

class AIBridge {
  final HealthBridge _healthBridge = HealthBridge();

  /// Fetch vitals and generate energy score
  Future<double> calculateEnergyScore() async {
    final vitals = await _healthBridge.readVitals();

    final avgHeartRate = vitals["avgHeartRate"] ?? 0;
    final energyBurned = vitals["energyBurned"] ?? 0;

    // Simple baseline AI logic (can evolve to ML later)
    double score = 100;

    if (avgHeartRate > 90) score -= 20;
    if (energyBurned > 500) score -= 15;

    return score.clamp(0, 100);
  }
}

import 'dart:math';

class CaffeineDecayModel {
  static const double halfLifeHours = 5.0;

  static double calculatePlasmaLevel(double amountMg, double timeElapsedHours) {
    if (timeElapsedHours < 0) return 0.0;
    return amountMg * pow(0.5, timeElapsedHours / halfLifeHours);
  }

  static Map<String, dynamic> getRecommendation(
      double currentLevel, int heartRate) {
    // Biometric Guardrails
    if (heartRate > 100) {
      return {
        "should_consume": false,
        "reason": "Heart rate is elevated. Caffeine not recommended.",
        "recommended_amount_mg": 0.0
      };
    }

    // Plasma Level Logic
    if (currentLevel > 150.0) {
      return {
        "should_consume": false,
        "reason": "Caffeine levels are high. Consuming more may cause jitters.",
        "recommended_amount_mg": 0.0
      };
    } else if (currentLevel < 50.0) {
      return {
        "should_consume": true,
        "reason": "Levels are low. A small boost could help focus.",
        "recommended_amount_mg": 80.0
      };
    } else {
      return {
        "should_consume": true,
        "reason": "Levels are moderate. You can top up if needed.",
        "recommended_amount_mg": 40.0
      };
    }
  }

  static Map<String, dynamic> processRequest({
    DateTime? lastIntakeTime,
    double lastIntakeAmount = 0.0,
    required DateTime currentTime,
    int heartRate = 70,
  }) {
    if (lastIntakeTime == null) {
      return getRecommendation(0.0, heartRate);
    }

    Duration diff = currentTime.difference(lastIntakeTime);
    double hoursElapsed = diff.inMinutes / 60.0;

    double currentLevel = calculatePlasmaLevel(lastIntakeAmount, hoursElapsed);

    Map<String, dynamic> rec = getRecommendation(currentLevel, heartRate);

    // Add calculated fields
    rec["current_plasma_level"] = double.parse(currentLevel.toStringAsFixed(2));

    // Calculate next allowable intake (drops below 50mg)
    if (currentLevel > 50) {
      double timeToDrop = 5 * log(50 / currentLevel) / log(0.5);
      rec["next_allowable_intake"] =
          currentTime.add(Duration(minutes: (timeToDrop * 60).round()));
    } else {
      rec["next_allowable_intake"] = currentTime;
    }

    return rec;
  }
}

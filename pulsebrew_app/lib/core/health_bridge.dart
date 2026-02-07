class HealthBridge {
  /// Mock health data for now (replace later with Health Connect / Google Fit)
  Future<Map<String, dynamic>> readVitals() async {
    return {
      "heartRate": 78,
      "sleepHours": 6.5,
      "stress": 0.6,
    };
  }
}

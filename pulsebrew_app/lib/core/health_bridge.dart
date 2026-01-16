import 'package:health/health.dart';

class HealthBridge {
  final Health _health = Health();

  final List<HealthDataType> _types = [
    HealthDataType.HEART_RATE,
    HealthDataType.STEPS,
    HealthDataType.ACTIVE_ENERGY_BURNED,
  ];

  Future<bool> requestPermissions() async {
    return await _health.requestAuthorization(_types);
  }

  /// 🔥 THIS METHOD WAS MISSING
  Future<Map<String, double>> readVitals() async {
    final now = DateTime.now();
    final yesterday = now.subtract(const Duration(hours: 24));

    final data = await _health.getHealthDataFromTypes(
      startTime: yesterday,
      endTime: now,
      types: _types,
    );

    double heartRate = 0;
    double energy = 0;
    int hrCount = 0;

    for (final record in data) {
      if (record.type == HealthDataType.HEART_RATE) {
        heartRate += (record.value as NumericHealthValue).numericValue;
        hrCount++;
      } else if (record.type == HealthDataType.ACTIVE_ENERGY_BURNED) {
        energy += (record.value as NumericHealthValue).numericValue;
      }
    }

    return {
      "avgHeartRate": hrCount == 0 ? 0 : heartRate / hrCount,
      "energyBurned": energy,
    };
  }
}

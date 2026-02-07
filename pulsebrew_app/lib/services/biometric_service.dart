import 'package:health/health.dart';

import 'dart:math';

abstract class BiometricService {
  Future<bool> requestPermissions();
  Future<int> getHeartRate();
}

class BiometricServiceImpl implements BiometricService {
  final Health _health = Health();

  @override
  Future<bool> requestPermissions() async {
    try {
      bool requested =
          await _health.requestAuthorization([HealthDataType.HEART_RATE]);
      return requested;
    } catch (e) {
      // debugPrint("Error: $e");
      return false;
    }
  }

  @override
  Future<int> getHeartRate() async {
    try {
      final now = DateTime.now();
      final oneHourAgo = now.subtract(const Duration(hours: 1));

      // v10+ API: getHealthDataFromTypes with named arguments
      List<HealthDataPoint> healthData = await _health.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: oneHourAgo,
        endTime: now,
      );

      if (healthData.isNotEmpty) {
        // v10: value is a HealthValue, usually NumericHealthValue for heart rate
        var val = healthData.last.value;
        return double.parse(val.toString()).round();
      }
    } catch (e) {
      // debugPrint("Error: $e");
    }

    // Fallback Mock
    return _getMockHeartRate();
  }

  int _getMockHeartRate() {
    return 60 + Random().nextInt(20);
  }
}

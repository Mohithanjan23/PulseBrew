import 'health_bridge.dart';
import 'caffeine_decision.dart';

class AIBridge {
  final HealthBridge _health = HealthBridge();

  Future<CaffeineDecision> decide() async {
    final vitals = await _health.readVitals();
    return CaffeineDecision.fromVitals(vitals);
  }
}

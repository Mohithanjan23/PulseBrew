import 'ai_bridge.dart';
import 'caffeine_decision.dart';

class CaffeineAI {
  final AIBridge _aiBridge = AIBridge();

  /// Main decision engine
  Future<CaffeineResult> decide() async {
    final energyScore = await _aiBridge.calculateEnergyScore();
    final now = DateTime.now();

    // 🌙 Sleep protection (after 6 PM)
    if (now.hour >= 18) {
      return const CaffeineResult(
        decision: CaffeineDecision.block,
        message: "Too late for caffeine. Let your body rest 🌙",
      );
    }

    // 🧠 Low energy → allow coffee
    if (energyScore < 50) {
      return const CaffeineResult(
        decision: CaffeineDecision.allow,
        message: "Your energy is low — perfect time for coffee ☕",
      );
    }

    // ⚖️ Medium energy → delay
    if (energyScore < 70) {
      return const CaffeineResult(
        decision: CaffeineDecision.delay,
        message: "Energy is okay. Try a short break before coffee ⏳",
      );
    }

    // 🚫 High energy → block
    return const CaffeineResult(
      decision: CaffeineDecision.block,
      message: "You're energized already. Skip caffeine 🚀",
    );
  }
}

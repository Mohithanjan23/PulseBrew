enum CaffeineDecision {
  allow,
  delay,
  block,
}

class CaffeineResult {
  final CaffeineDecision decision;
  final String message;

  const CaffeineResult({
    required this.decision,
    required this.message,
  });
}

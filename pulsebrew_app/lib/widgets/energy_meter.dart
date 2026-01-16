import 'package:flutter/material.dart';

@immutable
class EnergyMeter extends StatelessWidget {
  const EnergyMeter({super.key});

  @override
  Widget build(BuildContext context) {
    return const LinearProgressIndicator(value: 0.6);
  }
}

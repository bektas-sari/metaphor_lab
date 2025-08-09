import 'package:flutter/material.dart';

class ScoreChip extends StatelessWidget {
  final int score;
  const ScoreChip({super.key, required this.score});
  @override
  Widget build(BuildContext context) {
    return Chip(label: Text("Skor: $score"));
  }
}

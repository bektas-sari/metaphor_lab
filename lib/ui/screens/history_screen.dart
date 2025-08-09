import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../state/game_provider.dart';
import '../widgets/score_chip.dart';

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    final entries = game.entries;
    return Scaffold(
      appBar: AppBar(title: const Text('Geçmiş')),
      body: ListView.separated(
        padding: const EdgeInsets.all(16),
        itemBuilder: (_, i) {
          final e = entries[i];
          return ListTile(
            title: Text(e.text),
            subtitle: Text("${e.prompt.object} + ${e.prompt.concept} • ${DateFormat('dd.MM.yyyy HH:mm').format(e.createdAt)}"),
            trailing: ScoreChip(score: e.score),
          );
        },
        separatorBuilder: (_, __) => const Divider(height: 24),
        itemCount: entries.length,
      ),
    );
  }
}

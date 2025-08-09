import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:flutter/foundation.dart';
import '../models/metaphor_prompt.dart';
import '../models/metaphor_entry.dart';
import '../services/storage_service.dart';

class GameProvider extends ChangeNotifier {
  final StorageService _storage;
  final Random _rng = Random();

  List<String> _objects = [];
  List<String> _concepts = [];
  List<MetaphorEntry> entries = [];
  int streak = 0;

  MetaphorPrompt? current;

  GameProvider(this._storage);

  Future<void> init() async {
    _objects = List<String>.from(
        jsonDecode(await rootBundle.loadString('lib/data/prompts/objects.json')));
    _concepts = List<String>.from(
        jsonDecode(await rootBundle.loadString('lib/data/prompts/concepts.json')));

    entries = await _storage.loadEntries();
    streak = await _storage.loadStreak();
    newPrompt();
  }

  void newPrompt() {
    final object = _objects[_rng.nextInt(_objects.length)];
    final concept = _concepts[_rng.nextInt(_concepts.length)];
    current = MetaphorPrompt(object: object, concept: concept);
    notifyListeners();
  }

  int _score(String text, MetaphorPrompt p) {
    final words = text.trim().split(RegExp(r'\s+'));
    int s = 0;
    if (words.length >= 7) s += 20;
    final t = text.toLowerCase();
    if (t.contains('gibi') || t.contains('çünkü')) s += 20;
    if (t.contains(p.object.toLowerCase())) s += 15;
    if (t.contains(p.concept.toLowerCase())) s += 15;

    // çeşitlilik
    final freq = <String,int>{};
    for (final w in words) {
      final k = w.toLowerCase();
      freq[k] = (freq[k] ?? 0) + 1;
    }
    final maxCount = freq.values.isEmpty ? 1 : freq.values.reduce(max);
    final ratio = maxCount / words.length; // 0-1
    s += ((1 - ratio) * 30).round();

    return s.clamp(0, 100).toInt(); // ← ÖNEMLİ: int döndür
  }

  Future<void> submit(String text) async {
    if (current == null || text.trim().isEmpty) return;
    final score = _score(text, current!);
    final entry = MetaphorEntry(
      text: text.trim(),
      prompt: current!,
      score: score,
      createdAt: DateTime.now(),
    );
    entries.insert(0, entry);
    await _storage.saveEntries(entries);
    await _storage.updateStreakOnSubmit(DateTime.now());
    streak = await _storage.loadStreak();
    newPrompt();
  }
}

import 'metaphor_prompt.dart';

class MetaphorEntry {
  final String text;
  final MetaphorPrompt prompt;
  final int score; // 0-100
  final DateTime createdAt;

  MetaphorEntry({
    required this.text,
    required this.prompt,
    required this.score,
    required this.createdAt,
  });

  Map<String, dynamic> toJson() => {
    'text': text,
    'prompt': prompt.toJson(),
    'score': score,
    'createdAt': createdAt.toIso8601String(),
  };

  factory MetaphorEntry.fromJson(Map<String, dynamic> j) => MetaphorEntry(
    text: j['text'],
    prompt: MetaphorPrompt.fromJson(j['prompt']),
    score: j['score'],
    createdAt: DateTime.parse(j['createdAt']),
  );
}

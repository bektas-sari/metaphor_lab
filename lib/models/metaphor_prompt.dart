class MetaphorPrompt {
  final String object;
  final String concept;
  MetaphorPrompt({required this.object, required this.concept});

  Map<String, dynamic> toJson() => {'object': object, 'concept': concept};
  factory MetaphorPrompt.fromJson(Map<String, dynamic> j) =>
      MetaphorPrompt(object: j['object'], concept: j['concept']);
}

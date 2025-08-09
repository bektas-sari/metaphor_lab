import 'package:flutter/material.dart';
import '../../models/metaphor_prompt.dart';

class PromptCard extends StatelessWidget {
  final MetaphorPrompt prompt;
  const PromptCard({super.key, required this.prompt});
  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Nesne", style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(prompt.object, style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 12),
            Text("Kavram", style: Theme.of(context).textTheme.labelMedium),
            const SizedBox(height: 4),
            Text(prompt.concept, style: Theme.of(context).textTheme.headlineSmall),
          ],
        ),
      ),
    );
  }
}

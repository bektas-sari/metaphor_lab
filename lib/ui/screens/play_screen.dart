import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/game_provider.dart';
import '../widgets/primary_button.dart';
import '../widgets/prompt_card.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});
  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final game = context.watch<GameProvider>();
    final prompt = game.current;
    return Scaffold(
      appBar: AppBar(title: const Text('Metafor Üret')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            if (prompt != null) PromptCard(prompt: prompt),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "İpucu: “... gibi, çünkü ...” şablonunu deneyebilirsin.",
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _controller,
              minLines: 3,
              maxLines: 6,
              decoration: const InputDecoration(
                hintText: "Metaforunu yaz...",
              ),
            ),
            const Spacer(),
            PrimaryButton(
              label: "Gönder",
              onPressed: () async {
                final text = _controller.text;
                await game.submit(text);
                _controller.clear();
                if (!mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Kaydedildi ✅")),
                );
              },
            ),
            const SizedBox(height: 8),
            OutlinedButton(
              onPressed: () => game.newPrompt(),
              child: const Text("Yeni Soru"),
            ),
          ],
        ),
      ),
    );
  }
}

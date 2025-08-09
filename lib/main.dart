import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'core/theme.dart';
import 'services/storage_service.dart';
import 'state/game_provider.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/play_screen.dart';
import 'ui/screens/history_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MetaphorLabApp());
}

class MetaphorLabApp extends StatelessWidget {
  const MetaphorLabApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => GameProvider(StorageService())..init(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'MetaphorLab',
        theme: appTheme(),
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeScreen(),
          '/play': (_) => const PlayScreen(),
          '/history': (_) => const HistoryScreen(),
        },
      ),
    );
  }
}

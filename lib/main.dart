import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/language_detector_provider.dart';
import 'providers/chat_bot_provider.dart';
import 'providers/note_provider.dart';
import '../pages/splash_screen.dart';  // Import SplashScreen

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageDetectorProvider()),
        ChangeNotifierProvider(create: (_) => ChatBotProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(), // Tampilkan SplashScreen terlebih dahulu
    );
  }
}

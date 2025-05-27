import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/language_detector_provider.dart';
import 'providers/chat_bot_provider.dart';
import 'providers/note_provider.dart';
import 'providers/drawing_provider.dart';
import 'pages/splash_screen.dart';
import 'pages/home_page.dart';
import 'pages/note_list_page.dart';
import 'pages/note_form_page.dart';


void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => LanguageDetectorProvider()),
        ChangeNotifierProvider(create: (_) => ChatBotProvider()),
        ChangeNotifierProvider(create: (_) => NoteProvider()),
        ChangeNotifierProvider(create: (_) => DrawingProvider()),
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
      title: 'Serat Digital Mardlian',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        scaffoldBackgroundColor: Colors.white,
        useMaterial3: true,
      ),
      home: const SplashScreen(),
      routes: {
        '/home': (context) => const HomePage(),
        '/notes': (context) => const NoteListPage(),
        '/notes/form': (context) => const NoteFormPage(),
      },
    );
  }
}

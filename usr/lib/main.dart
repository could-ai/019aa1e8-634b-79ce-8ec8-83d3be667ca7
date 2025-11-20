import 'package:flutter/material.dart';
import 'chat_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SK Hacker AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF00FF00), // Hacker Green
        scaffoldBackgroundColor: Colors.black,
        colorScheme: const ColorScheme.dark(
          primary: Color(0xFF00FF00),
          secondary: Color(0xFF008F11),
          surface: Color(0xFF111111),
        ),
        fontFamily: 'Courier', // Monospace font for hacker look
        useMaterial3: true,
      ),
      // Routing setup
      initialRoute: '/',
      routes: {
        '/': (context) => const ChatScreen(),
      },
    );
  }
}

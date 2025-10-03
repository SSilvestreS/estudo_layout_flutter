import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() => runApp(const GamersBrawlApp());

class GamersBrawlApp extends StatelessWidget {
  const GamersBrawlApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Gamers Brawl',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const LoginScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
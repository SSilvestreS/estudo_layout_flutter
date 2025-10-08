import 'package:flutter/material.dart';
import 'package:media_kit/media_kit.dart';
import 'lib/screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  MediaKit.ensureInitialized();
  runApp(const RegisterTestApp());
}

class RegisterTestApp extends StatelessWidget {
  const RegisterTestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste Register Screen',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

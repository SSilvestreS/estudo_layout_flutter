import 'package:flutter/material.dart';
import 'screens/register_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const TestRegisterApp());
}

class TestRegisterApp extends StatelessWidget {
  const TestRegisterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Teste - Tela de Registro',
      theme: ThemeData(
        primarySwatch: Colors.green,
        useMaterial3: true,
      ),
      home: const RegisterScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

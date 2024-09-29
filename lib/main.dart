import 'package:flutter/material.dart';
import 'package:helios_flutter_julien/screens/list_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: const ListScreen(),
    );
  }
}

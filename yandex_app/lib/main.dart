import 'package:flutter/material.dart';
import 'package:yandex_app/modules/home/presentation/home_screen.dart';

void main() {
  runApp(const YandexApp());
}

class YandexApp extends StatelessWidget {
  const YandexApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: HomeScreen(),
    );
  }
}

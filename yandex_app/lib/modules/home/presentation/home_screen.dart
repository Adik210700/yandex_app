import 'package:flutter/material.dart';
import 'package:yandex_app/core/extension/context_extension.dart';
import 'package:yandex_app/modules/map/presentation/map_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.push(MapScreen());
            },
            child: Text('Go to map')),
      ),
    );
  }
}

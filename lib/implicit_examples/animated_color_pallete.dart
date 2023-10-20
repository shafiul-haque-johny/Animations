import 'package:flutter/material.dart';
import 'dart:math';

class AnimatedColorPalette extends StatefulWidget {
  const AnimatedColorPalette({super.key});

  @override
  State<AnimatedColorPalette> createState() => _AnimatedColorPaletteState();
}

class _AnimatedColorPaletteState extends State<AnimatedColorPalette> {
  List<Color> currentPalette = generateRandomPalette();

  static List<Color> generateRandomPalette() {
    final random = Random();
    return List.generate(
      4,
      (_) => Color.fromRGBO(
        random.nextInt(256),
        random.nextInt(256),
        random.nextInt(256),
        1,
      ),
    );
  }

  void regeneratePalette() {
    setState(() {
      currentPalette = generateRandomPalette();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Color Palette Generator'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (Color color in currentPalette)
            /*
            200ms -> 20%
            400ms -> 40%
            600ms -> 60%
            800ms -> 80%
            1000ms -> 100%
             */
              AnimatedContainer(
                curve: Curves.linear,
                duration: const Duration(microseconds: 1000),
                width: 100,
                height: 100,
                color: color,
                margin: const EdgeInsets.all(8),
              ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: regeneratePalette,
              child: const Text('Generate New Palette'),
            ),
          ],
        ),
      ),
    );
  }
}

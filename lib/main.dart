import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart'; // Adjust the import path

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final game = FlappyBirdGame();

    return MaterialApp(
      title: 'Flappy Bird Clone',
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget<FlappyBirdGame>(
              game: game,
              overlayBuilderMap: {
                'GameOver': (BuildContext context, FlappyBirdGame game) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          color: Colors.black54,
                          child: const Text(
                            'Game Over',
                            style: TextStyle(fontSize: 48, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () {
                            game.restart(); // Call restart method
                          },
                          child: const Text('Restart'),
                        ),
                      ],
                    ),
                  );
                },
              },
              initialActiveOverlays: const [], // No overlay active initially
            ),
          ],
        ),
      ),
    );
  }
}

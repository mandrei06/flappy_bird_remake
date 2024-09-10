import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flappy_bird/game/flappy_bird_game.dart';

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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        body: Stack(
          children: [
            GameWidget<FlappyBirdGame>(game: game),
            // Handle tap event for restarting the game
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  if (game.isGameOver) {
                    game.restart(); // Method to restart the game
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

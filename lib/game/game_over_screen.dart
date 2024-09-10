import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import '../components/restart_button.dart';
import 'flappy_bird_game.dart';

class GameOverScreen extends PositionComponent with HasGameRef<FlappyBirdGame> {
  @override
  Future<void> onLoad() async {
    size = gameRef.size;

    add(RectangleComponent(
      position: Vector2.zero(),
      size: size,
      paint: Paint()..color = Colors.black.withOpacity(0.5),
    ));

    final restartButton = RestartButton(
      onPressed: () {
        gameRef.restart();
        removeFromParent(); // Remove GameOverScreen after restarting
      },
    );
    restartButton.position = size / 2 - Vector2(100, 25); // Center the button
    add(restartButton);
  }
}

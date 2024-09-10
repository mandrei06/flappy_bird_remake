import 'dart:async'; // Ensure this is imported
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math'; // For random number generation


import '../background_component.dart';
import 'game_over_screen.dart';


import 'dart:async';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import '../background_component.dart';
import '../components/restart_button.dart';

class FlappyBirdGame extends FlameGame with TapDetector {
  late final SpriteComponent bird;
  bool isFlapping = false;
  double birdYSpeed = 0;
  double flapStrength = -150;
  static const double gravity = 200;
  final List<SpriteComponent> obstacles = [];
  final Random _random = Random();
  late TimerComponent obstacleTimer;
  bool isGameOver = false;
  bool gamePaused = false;

  @override
  Future<void> onLoad() async {
    add(BackgroundComponent()..size = size);

    final birdImage = await images.load('bird.png');
    bird = SpriteComponent()
      ..sprite = Sprite(birdImage)
      ..size = Vector2(100.0, 100.0)
      ..position = Vector2(size.x / 4, size.y / 2);

    add(bird);

    obstacleTimer = TimerComponent(
      period: 2,
      repeat: true,
      onTick: () => addObstacle(),
    );
    add(obstacleTimer);
  }

  @override
  void update(double dt) {
    if (isGameOver) return;

    super.update(dt);

    if (isFlapping) {
      flapStrength += -50 * dt;
      birdYSpeed = flapStrength;
    }

    birdYSpeed += gravity * dt;
    bird.position.y += birdYSpeed * dt;

    if (bird.position.y > size.y - bird.size.y) {
      bird.position.y = size.y - bird.size.y;
      birdYSpeed = 0;
    }
    if (bird.position.y < 0) {
      bird.position.y = 0;
      birdYSpeed = 0;
    }

    final obstaclesToRemove = <SpriteComponent>[];
    for (var obstacle in obstacles) {
      obstacle.position.x -= 100 * dt;
      if (obstacle.position.x < -obstacle.size.x) {
        obstaclesToRemove.add(obstacle);
      }
    }

    for (var obstacle in obstaclesToRemove) {
      remove(obstacle);
      obstacles.remove(obstacle);
    }

    for (var obstacle in obstacles) {
      if (bird.toRect().overlaps(obstacle.toRect())) {
        gameOver();
        return;
      }
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    if (isGameOver) return;
    isFlapping = true;
  }

  @override
  void onTapUp(TapUpInfo info) {
    if (isGameOver) return;
    isFlapping = false;
    flapStrength = -150;
  }

  @override
  void onTapCancel() {
    if (isGameOver) return;
    isFlapping = false;
    flapStrength = -150;
  }

  Future<void> addObstacle() async {
    final obstacleImage = await images.load('obstacle.png');
    final obstacleSprite = Sprite(obstacleImage);

    final double obstacleYPosition = _random.nextDouble() * (size.y - 200);
    final obstacle = SpriteComponent()
      ..sprite = obstacleSprite
      ..size = Vector2(60.0, 200.0)
      ..position = Vector2(size.x, obstacleYPosition);

    add(obstacle);
    obstacles.add(obstacle);
  }

  void flap() {
    if (isGameOver) return;
    isFlapping = true;
  }

  void gameOver() {
    isGameOver = true;
    gamePaused = true; // Ensure the game is paused
    add(GameOverScreen()); // Add GameOverScreen
  }

  void restart() {
    isGameOver = false;
    gamePaused = false; // Resume the game

    bird.position = Vector2(size.x / 4, size.y / 2);
    birdYSpeed = 0;
    flapStrength = -150;
    obstacles.forEach(remove);
    obstacles.clear();

    remove(obstacleTimer);
    obstacleTimer = TimerComponent(
      period: 2,
      repeat: true,
      onTick: () => addObstacle(),
    );
    add(obstacleTimer);
  }
}

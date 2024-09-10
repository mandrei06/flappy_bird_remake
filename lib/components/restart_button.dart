import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class RestartButton extends PositionComponent {
  final VoidCallback onPressed;

  RestartButton({required this.onPressed});

  @override
  Future<void> onLoad() async {
    size = Vector2(200, 50);

    add(RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.red,
    ));

    add(TextComponent(
      text: 'Restart',
      textRenderer: TextPaint(style: TextStyle(fontSize: 24, color: Colors.white)),
      position: Vector2(size.x / 4, size.y / 4),
    ));
  }
}

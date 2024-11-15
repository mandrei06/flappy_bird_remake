import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';

class RestartButton extends PositionComponent with TapCallbacks {
  final VoidCallback onPressed;

  RestartButton({required this.onPressed});

  @override
  Future<void> onLoad() async {
    print("it's getting here in button");
    size = Vector2(200, 50);

    // Background rectangle
    add(RectangleComponent(
      size: size,
      paint: Paint()..color = Colors.red,
    ));

    // Text on button
    add(TextComponent(
      text: 'Restart',
      textRenderer: TextPaint(style: TextStyle(fontSize: 24, color: Colors.white)),
      position: Vector2(size.x / 4, size.y / 4),
    ));
  }

  @override
  void onTapDown(TapDownEvent event) {
    // Check if the tap is within the button's bounds
    if (toRect().contains(event.localPosition.toOffset())) {
      onPressed();
    }
  }
}

import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class BackgroundComponent extends PositionComponent {
  @override
  void render(Canvas canvas) {
    super.render(canvas);
    final paint = Paint()..color = Colors.cyan;
    final rect = Offset.zero & size.toSize(); // Convert Vector2 to Size
    canvas.drawRect(rect, paint); // Draw a white rectangle
  }
}

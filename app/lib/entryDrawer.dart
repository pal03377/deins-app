import 'dart:ui';

import 'package:deins/Entry.dart';
import 'package:flutter/material.dart';

drawEntryOnCanvas(Canvas canvas, Size size, Entry entry) {
  Paint paint = new Paint()
    ..strokeCap = StrokeCap.round
    ..style = PaintingStyle.stroke
    ..strokeWidth = 0.08 * size.width
    ..shader = RadialGradient(
      colors: entry.type.colors,
    ).createShader(Rect.fromCircle(
      center: Offset(0.0, 0.0),
      radius: size.width,
    ));

  List<Offset> pointsScaledUp = [];
  // points are stores relative to size, so scale them up again
  for (Offset p in entry.drawPoints) {
    if (p == null) {
      pointsScaledUp.add(null);
      continue;
    }
    pointsScaledUp.add(Offset(p.dx * size.width, p.dy * size.height));
  }
  List<Offset> offsetPoints = [];
  // https://ptyagicodecamp.github.io/building-cross-platform-finger-painting-app-in-flutter.html
  for (int i = 0; i < pointsScaledUp.length - 1; i++) {
    if (pointsScaledUp[i] != null && pointsScaledUp[i + 1] != null) {
      // Drawing line when two consecutive points are available
      canvas.drawLine(pointsScaledUp[i], pointsScaledUp[i + 1], paint);
    } else if (pointsScaledUp[i] != null && pointsScaledUp[i + 1] == null) {
      offsetPoints.clear();
      offsetPoints.add(pointsScaledUp[i]);
      offsetPoints.add(Offset(pointsScaledUp[i].dx + 0.1, pointsScaledUp[i].dy + 0.1));
      // Draw points when two points are not next to each other
      canvas.drawPoints(PointMode.points, offsetPoints, paint);
    }
  }
}

import 'dart:ui';

import 'package:deins/Entry.dart';
import 'package:deins/TouchPoint.dart';
import 'package:flutter/material.dart';


class TypeDraw extends StatefulWidget {
  final Entry _entry;
  TypeDraw(this._entry);

  @override
  _TypeDrawState createState() => _TypeDrawState(_entry);
}

class _TypeDrawState extends State<TypeDraw> {
  Entry _entry;
  _TypeDrawState(this._entry);

  @override
  Widget build(BuildContext context) {
    Size size = Size(200, 200);
    Path path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width, 0.0);
    path.lineTo(size.width, size.height * 0.8);
    path.lineTo(0.0, size.height);
    path.close();

    return GestureDetector(
      child: ClipPath(
        clipper: PathClipper(path),
        child: CustomPaint(
          size: Size(200, 200),
          painter: DrawPainter(_entry, path)
        )
      ), 
      onPanStart: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          _entry.drawPoints.add(TouchPoint(
            points: renderBox.globalToLocal(details.globalPosition)
          ));
        });
      },
      onPanUpdate: (details) {
        setState(() {
          RenderBox renderBox = context.findRenderObject();
          _entry.drawPoints.add(TouchPoint(
            points: renderBox.globalToLocal(details.globalPosition)
          ));
        });
      },
      onPanEnd: (details) {
        setState(() {
          _entry.drawPoints.add(null);
        });
      }
    );
  }
}


class DrawPainter extends CustomPainter {
  Entry _entry;
  List<Offset> offsetPoints = List();
  Path _path;

  DrawPainter(this._entry, this._path);

  Entry getEntry() { return _entry; }

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    Paint borderPaint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 28;
    canvas.drawPath(_path, borderPaint);

    // https://ptyagicodecamp.github.io/building-cross-platform-finger-painting-app-in-flutter.html
    for (int i = 0; i < _entry.drawPoints.length - 1; i++) {
      if (_entry.drawPoints[i] != null && _entry.drawPoints[i + 1] != null) {
        // Drawing line when two consecutive points are available
        canvas.drawLine(_entry.drawPoints[i].points, _entry.drawPoints[i + 1].points, paint);
      } else if (_entry.drawPoints[i] != null && _entry.drawPoints[i + 1] == null) {
        offsetPoints.clear();
        offsetPoints.add(_entry.drawPoints[i].points);
        offsetPoints.add(Offset(_entry.drawPoints[i].points.dx + 0.1, _entry.drawPoints[i].points.dy + 0.1));
        // Draw points when two points are not next to each other
        canvas.drawPoints(PointMode.points, offsetPoints, paint);
      }
    }
  }
  
  @override
  bool shouldRepaint(covariant DrawPainter oldDelegate) {
    return true;
  }
}


class PathClipper extends CustomClipper<Path> {
  Path _path;
  PathClipper(this._path);

  @override
  Path getClip(Size size) {
    return _path;
  }
  
  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return false;
  }
}

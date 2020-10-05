import 'dart:ui';

import 'package:deins/Entry.dart';
import 'package:deins/TouchPoint.dart';
import 'package:flutter/material.dart';


class TypeDraw extends StatefulWidget {
  Entry _entry;
  Size _size;
  bool disabled = false;
  TypeDraw(this._entry, this._size);
  TypeDraw.possibleDisable(this._entry, this._size, this.disabled);

  @override
  _TypeDrawState createState() => _TypeDrawState(_entry, _size, disabled);
}

class _TypeDrawState extends State<TypeDraw> {
  Entry _entry;
  Size _size;
  bool _disabled = false;
  _TypeDrawState(this._entry, this._size, this._disabled);

  @override
  Widget build(BuildContext context) {
    Path path = _entry.type.shape;
    // resize path to fit size - https://stackoverflow.com/a/57874894/4306257
    final Rect pathBounds = path.getBounds();

    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale(_size.width / pathBounds.width, _size.height / pathBounds.height);
    path = path.transform(matrix4.storage);

    return IgnorePointer(
      ignoring: _disabled, 
      child: GestureDetector(
        child: ClipPath(
          clipper: PathClipper(path),
          child: CustomPaint(
            size: _size,
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
      ),
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
    Paint backgroundPaint = new Paint()
      ..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    Paint paint = new Paint()
      ..color = _entry.type.color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.08 * size.width;

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

    Paint borderPaint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.08 * size.width;
    Path borderPath = Path.from(_path);
    // scale down border path so that not half of the line is clipped away
    final Rect pathBounds = borderPath.getBounds();
    final Matrix4 matrix4 = Matrix4.identity();
    matrix4.scale((pathBounds.width - borderPaint.strokeWidth) / pathBounds.width, (pathBounds.width - borderPaint.strokeWidth) / pathBounds.height);
    matrix4.translate(borderPaint.strokeWidth / 2, borderPaint.strokeWidth / 2);
    borderPath = borderPath.transform(matrix4.storage);
    canvas.drawPath(borderPath, borderPaint);
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

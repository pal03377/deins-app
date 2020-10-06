import 'dart:ui';

import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TypeDraw extends StatefulWidget {
  final Entry _entry;
  final Size _size;
  final bool _disabled;
  TypeDraw(this._entry, this._size, this._disabled);

  @override
  _TypeDrawState createState() => _TypeDrawState(_entry, _size, _disabled);
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
      ignoring: false, /*_disabled*/
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
            Offset point = renderBox.globalToLocal(details.globalPosition);
            // store point relative to size
            point = Offset(point.dx / _size.width, point.dy / _size.height);
            _entry.drawPoints.add(point);
          });
        },
        onPanUpdate: (details) {
          setState(() {
            RenderBox renderBox = context.findRenderObject();
            Offset point = renderBox.globalToLocal(details.globalPosition);
            // store point relative to size
            point = Offset(point.dx / _size.width, point.dy / _size.height);
            _entry.drawPoints.add(point);
          });
        },
        onPanEnd: (details) {
          setState(() {
            _entry.drawPoints.add(null);
          });
          Provider.of<EntryModel>(context, listen: false).indicateChange();
        }
      ),
    );
  }
}


class DrawPainter extends CustomPainter {
  Entry entry;
  List<Offset> offsetPoints = List();
  Path _path;

  DrawPainter(this.entry, this._path);

  @override
  void paint(Canvas canvas, Size size) {  
    Paint backgroundPaint = new Paint()
      ..color = Colors.white;
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), backgroundPaint);

    Paint paint = new Paint()
      ..color = entry.type.color
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.08 * size.width;

    List<Offset> pointsScaledUp = [];
    // points are stores relative to size, so scale them up again
    for (Offset p in entry.drawPoints) {
      if (p == null) {
        pointsScaledUp.add(null);
        continue;
      }
      pointsScaledUp.add(Offset(p.dx * size.width, p.dy * size.height));
    }
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

    Paint borderPaint = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.08 * size.width;
    canvas.drawPath(_path, borderPaint);
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

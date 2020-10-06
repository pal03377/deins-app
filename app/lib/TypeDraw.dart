import 'dart:math';
import 'dart:ui';

import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TypeDraw extends StatelessWidget {
  final Entry entry;
  final Size size;
  final bool disabled;
  final Color fillColor;
  TypeDraw({ this.entry, this.size, this.disabled, this.fillColor=Colors.white });

  @override
  Widget build(BuildContext context) {
    Path path = entry.type.shape;
    // resize path to fit size - https://stackoverflow.com/a/57874894/4306257
    final Rect pathBounds = path.getBounds();

    final Matrix4 matrix4 = Matrix4.identity();
    // shapes are drawn based on a 100x100 area
    matrix4.scale(min(size.width / pathBounds.width, size.height / 100));
    path = path.transform(matrix4.storage);

    return IgnorePointer(
      ignoring: false, /*_disabled*/
      child: GestureDetector(
        child: ClipPath(
          clipper: PathClipper(path),
          child: CustomPaint(
            size: size,
            painter: DrawPainter(entry, path, fillColor)
          )
        ), 
        onPanStart: (details) {
          RenderBox renderBox = context.findRenderObject();
          Offset point = renderBox.globalToLocal(details.globalPosition);
          // store point relative to size
          point = Offset(point.dx / size.width, point.dy / size.height);
          entry.drawPoints.add(point);
          Provider.of<EntryModel>(context, listen: false).indicateChange();
        },
        onPanUpdate: (details) {
          RenderBox renderBox = context.findRenderObject();
          Offset point = renderBox.globalToLocal(details.globalPosition);
          // store point relative to size
          point = Offset(point.dx / size.width, point.dy / size.height);
          entry.drawPoints.add(point);
          Provider.of<EntryModel>(context, listen: false).indicateChange();
        },
        onPanEnd: (details) {
          entry.drawPoints.add(null);
          Provider.of<EntryModel>(context, listen: false).indicateChange();
        }
      )
    );
  }
}


class DrawPainter extends CustomPainter {
  Entry entry;
  List<Offset> offsetPoints = List();
  Path _path;
  Color _fillColor;

  DrawPainter(this.entry, this._path, this._fillColor);

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = new Paint()
      ..color = _fillColor;
    // draw background color such that it pretty much exactly behind the shape
    canvas.drawPath(_path, backgroundPaint);

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
  Path path;
  PathClipper(this.path);

  @override
  Path getClip(Size size) {
    return path;
  }
  
  @override
  bool shouldReclip(covariant PathClipper oldClipper) {
    return path != oldClipper.path;
  }
}

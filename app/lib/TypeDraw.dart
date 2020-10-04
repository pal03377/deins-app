import 'package:deins/Entry.dart';
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
    return CustomPaint(
      size: Size(200, 200),
      painter: DrawPainter(_entry)
    );
  }
}


class DrawPainter extends CustomPainter {
  Entry _entry;
  DrawPainter(this._entry);

  Entry getEntry() { return _entry; }

  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = Colors.black
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 12;
    canvas.drawRRect(RRect.fromLTRBR(0, 200, 200, 0, Radius.circular(12)), line);
  }
  
  @override
  bool shouldRepaint(covariant DrawPainter oldDelegate) {
    return oldDelegate.getEntry() != _entry;
  }
}

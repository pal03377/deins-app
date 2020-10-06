import 'package:flutter/material.dart';


class EntryType {
  static const none = 0;
  static const career = 1;
  static const health = 2;
  static const self = 3;
  static const friends = 4;

  var _me;
  EntryType(this._me);

  bool get empty {
    return _me == EntryType.none;
  }

  String get name {
    switch (_me) {
      case EntryType.none: return "?";
      case EntryType.career: return "career";
      case EntryType.health: return "health";
      case EntryType.self: return "self";
      case EntryType.friends: return "friends";
      default: return null;
    }
  }

  Color get color {
    switch (_me) {
      case EntryType.none: return Colors.white;
      case EntryType.career: return Colors.yellow;
      case EntryType.health: return Colors.green;
      case EntryType.self: return Colors.red;
      case EntryType.friends: return Colors.blue;
      default: return null;
    }
  }

  Path get shape {
    Path res = Path();
    switch (_me) {
      case EntryType.none:
        break;
      case EntryType.career:
        // draw triangle
        Size size = Size(100, 87);
        res.lineTo(size.width * 0.54, size.height * 0.05);
        res.cubicTo(size.width * 0.54, size.height * 0.05, size.width * 0.55, size.height * 0.05, size.width * 0.55, size.height * 0.05);
        res.cubicTo(size.width * 0.55, size.height * 0.05, size.width * 1.04, size.height * 1.04, size.width * 1.04, size.height * 1.04);
        res.cubicTo(size.width * 1.04, size.height * 1.04, size.width * 1.04, size.height * 1.04, size.width * 1.04, size.height * 1.04);
        res.cubicTo(size.width * 1.04, size.height * 1.04, size.width * 1.04, size.height * 1.05, size.width * 1.04, size.height * 1.05);
        res.cubicTo(size.width * 1.04, size.height * 1.05, size.width * 0.05, size.height * 1.05, size.width * 0.05, size.height * 1.05);
        res.cubicTo(size.width * 0.05, size.height * 1.05, size.width * 0.04, size.height * 1.05, size.width * 0.04, size.height * 1.05);
        res.cubicTo(size.width * 0.04, size.height * 1.04, size.width * 0.04, size.height * 1.04, size.width * 0.04, size.height * 1.04);
        res.cubicTo(size.width * 0.04, size.height * 1.04, size.width * 0.54, size.height * 0.05, size.width * 0.54, size.height * 0.05);
        res.cubicTo(size.width * 0.54, size.height * 0.05, size.width * 0.54, size.height * 0.05, size.width * 0.54, size.height * 0.05);
        res.cubicTo(size.width * 0.54, size.height * 0.05, size.width * 0.54, size.height * 0.05, size.width * 0.54, size.height * 0.05);
        break;
      case EntryType.health:
        // draw pentagon
        Size size = Size(92, 92);
        res.lineTo(size.width * 0.51, size.height * 0.1);
        res.cubicTo(size.width * 0.51, size.height * 0.1, size.width * 0.54, size.height * 0.08, size.width * 0.55, size.height * 0.08);
        res.cubicTo(size.width * 0.56, size.height * 0.08, size.width * 0.59, size.height * 0.1, size.width * 0.59, size.height * 0.1);
        res.cubicTo(size.width * 0.59, size.height * 0.1, size.width * 1.04, size.height * 0.44, size.width * 1.04, size.height * 0.44);
        res.cubicTo(size.width * 1.04, size.height * 0.44, size.width * 1.05, size.height * 0.45, size.width * 1.05, size.height * 0.46);
        res.cubicTo(size.width * 1.05, size.height * 0.46, size.width * 1.05, size.height * 0.47, size.width * 1.05, size.height * 0.47);
        res.cubicTo(size.width * 1.05, size.height * 0.47, size.width * 0.87, size.height * 1.06, size.width * 0.87, size.height * 1.06);
        res.cubicTo(size.width * 0.87, size.height * 1.06, size.width * 0.86, size.height * 1.07, size.width * 0.86, size.height * 1.08);
        res.cubicTo(size.width * 0.86, size.height * 1.08, size.width * 0.85, size.height * 1.08, size.width * 0.85, size.height * 1.08);
        res.cubicTo(size.width * 0.85, size.height * 1.08, size.width * 0.26, size.height * 1.08, size.width * 0.26, size.height * 1.08);
        res.cubicTo(size.width * 0.26, size.height * 1.08, size.width / 4, size.height * 1.08, size.width * 0.24, size.height * 1.07);
        res.cubicTo(size.width * 0.24, size.height * 1.07, size.width * 0.23, size.height * 1.06, size.width * 0.23, size.height * 1.06);
        res.cubicTo(size.width * 0.23, size.height * 1.06, size.width * 0.05, size.height * 0.47, size.width * 0.05, size.height * 0.47);
        res.cubicTo(size.width * 0.05, size.height * 0.47, size.width * 0.05, size.height * 0.46, size.width * 0.05, size.height * 0.45);
        res.cubicTo(size.width * 0.05, size.height * 0.45, size.width * 0.06, size.height * 0.45, size.width * 0.06, size.height * 0.45);
        res.cubicTo(size.width * 0.06, size.height * 0.45, size.width * 0.51, size.height * 0.1, size.width * 0.51, size.height * 0.1);
        res.cubicTo(size.width * 0.51, size.height * 0.1, size.width * 0.51, size.height * 0.1, size.width * 0.51, size.height * 0.1);
        break;
      case EntryType.self:
        res.addOval(Rect.fromCircle(
          center: Offset(50, 50),
          radius: 45.0,
        ));
        break;
      case EntryType.friends:
        res.addRRect(RRect.fromRectAndRadius(
          Rect.fromCircle(
            center: Offset(50, 50),
            radius: 40.0,
          ), 
          Radius.circular(8)
        ));
        break;
    }
    return res;
  }
}


List<EntryType> allEntryTypes = [
  EntryType(EntryType.career),
  EntryType(EntryType.health),
  EntryType(EntryType.self),
  EntryType(EntryType.friends)
];

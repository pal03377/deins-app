import 'package:flutter/material.dart';


class EntryType {
  static const career = 1;
  static const health = 2;
  static const personality = 3;
  static const friends = 4;

  var _me;
  EntryType(this._me);

  String get name {
    switch (_me) {
      case EntryType.career: return "career";
      case EntryType.health: return "health";
      case EntryType.personality: return "personality";
      case EntryType.friends: return "friends";
      default: return null;
    }
  }

  Color get color {
    switch (_me) {
      case EntryType.career: return Colors.red;
      case EntryType.health: return Colors.green;
      case EntryType.personality: return Colors.blue;
      case EntryType.friends: return Colors.pink;
      default: return null;
    }
  }

  Path get shape {
    Path res = Path();
    switch (_me) {
      case EntryType.career:
        // draw triangle
        res.moveTo(0, 200);
        res.lineTo(200, 200);
        res.lineTo(100, 0);
        res.close();
        break;
      case EntryType.health:
        res.addOval(Rect.fromCircle(
          center: Offset(50, 50),
          radius: 50.0,
        ));
        break;
      case EntryType.personality:
        res.addOval(Rect.fromCircle(
          center: Offset(50, 50),
          radius: 50.0,
        ));
        break;
      case EntryType.friends:
        res.addOval(Rect.fromCircle(
          center: Offset(50, 50),
          radius: 50.0,
        ));
        break;
    }
    return res;
  }
}

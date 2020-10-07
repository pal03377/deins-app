import 'package:deins/colors.dart';
import 'package:flutter/material.dart';


class EntryType {
  static const none = 0;
  static const career = 1;
  static const health = 2;
  static const personality = 3;
  static const friends = 4;
  static const relationship = 5;
  static const environment = 6;
  static const sleep = 7;
  static const finances = 8;

  var _me;
  EntryType(this._me);
  EntryType.fromName(String name) {
    if (name == null) {
      this._me = EntryType.none;
      return;
    }
    switch (name) {
      case "?": this._me = EntryType.none; break;
      case "career": this._me = EntryType.career; break;
      case "health": this._me = EntryType.health; break;
      case "personality": this._me = EntryType.personality; break;
      case "friends": this._me = EntryType.friends; break;
      case "relationship": this._me = EntryType.relationship; break;
      case "environment": this._me = EntryType.environment; break;
      case "sleep": this._me = EntryType.sleep; break;
      case "finances": this._me = EntryType.finances; break;
      default:
        print("name " + (name != null ? name : "[falsy value]") + " not recognized");
        this._me = EntryType.none;
    }
  }

  bool get empty {
    return _me == EntryType.none;
  }

  String get name {
    switch (_me) {
      case EntryType.none: return "?";
      case EntryType.career: return "career";
      case EntryType.health: return "health";
      case EntryType.personality: return "personality";
      case EntryType.friends: return "friends";
      case EntryType.relationship: return "relationship";
      case EntryType.environment: return "environment";
      case EntryType.sleep: return "sleep";
      case EntryType.finances: return "finances";
      default: return null;
    }
  }

  List<Color> get colors {
    switch (_me) {
      case EntryType.none: return [whiteBg, whiteBg];
      case EntryType.career: return [etYellow, etYellow2];
      case EntryType.health: return [etTurquoise, etTurquoise2];
      case EntryType.personality: return [etRed, etRed2];
      case EntryType.friends: return [etBlue, etBlue2];
      case EntryType.relationship: return [etHeart, etHeart2];
      case EntryType.environment: return [etLightgreen, etLightgreen2];
      case EntryType.sleep: return [etStar, etStar2];
      case EntryType.finances: return [etPurple, etPurple2];
      default: return null;
    }
  }

  Path get shape {
    Path res = Path();
    // most of these are generated with https://www.flutterclutter.dev/tools/svg-to-flutter-path-converter
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
      case EntryType.personality:
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
      case EntryType.relationship:
        Size size = Size(92, 92);
        res.moveTo(size.width * 0.54, size.height / 5);
        res.cubicTo(size.width * 0.64, size.height * 0.01, size.width * 0.86, size.height * 0.01, size.width * 0.96, size.height * 0.11);
        res.cubicTo(size.width * 1.07, size.height / 5, size.width * 1.07, size.height * 0.42, size.width * 0.96, size.height * 0.63);
        res.cubicTo(size.width * 0.89, size.height * 0.78, size.width * 0.7, size.height * 0.94, size.width * 0.54, size.height * 1.04);
        res.cubicTo(size.width * 0.38, size.height * 0.94, size.width * 0.19, size.height * 0.78, size.width * 0.12, size.height * 0.63);
        res.cubicTo(size.width * 0.01, size.height * 0.42, size.width * 0.01, size.height / 5, size.width * 0.12, size.height * 0.11);
        res.cubicTo(size.width * 0.22, size.height * 0.01, size.width * 0.43, size.height * 0.01, size.width * 0.54, size.height / 5);
        res.cubicTo(size.width * 0.54, size.height / 5, size.width * 0.54, size.height / 5, size.width * 0.54, size.height / 5);
        break;
      case EntryType.environment:
        Size size = Size(92, 92);
        res.moveTo(size.width * 0.41, size.height * 1.05);
        res.cubicTo(size.width * 0.34, size.height * 1.05, size.width * 0.16, size.height * 0.91, size.width * 0.13, size.height * 0.84);
        res.cubicTo(size.width * 0.11, size.height * 0.78, size.width * 0.29, size.height * 0.69, size.width * 0.27, size.height * 0.65);
        res.cubicTo(size.width * 0.26, size.height * 0.6, size.width * 0.07, size.height * 0.64, size.width * 0.05, size.height * 0.57);
        res.cubicTo(size.width * 0.03, size.height * 0.51, size.width * 0.1, size.height * 0.29, size.width * 0.15, size.height * 0.24);
        res.cubicTo(size.width / 5, size.height / 5, size.width * 0.34, size.height * 0.34, size.width * 0.38, size.height * 0.32);
        res.cubicTo(size.width * 0.41, size.height * 0.29, size.width * 0.32, size.height * 0.12, size.width * 0.38, size.height * 0.08);
        res.cubicTo(size.width * 0.43, size.height * 0.04, size.width * 0.66, size.height * 0.04, size.width * 0.72, size.height * 0.08);
        res.cubicTo(size.width * 0.77, size.height * 0.12, size.width * 0.68, size.height * 0.29, size.width * 0.72, size.height * 0.32);
        res.cubicTo(size.width * 0.75, size.height * 0.34, size.width * 0.88, size.height / 5, size.width * 0.94, size.height * 0.24);
        res.cubicTo(size.width, size.height * 0.29, size.width * 1.06, size.height * 0.51, size.width * 1.04, size.height * 0.57);
        res.cubicTo(size.width * 1.02, size.height * 0.64, size.width * 0.83, size.height * 0.6, size.width * 0.82, size.height * 0.65);
        res.cubicTo(size.width * 0.81, size.height * 0.69, size.width * 0.98, size.height * 0.78, size.width * 0.96, size.height * 0.84);
        res.cubicTo(size.width * 0.93, size.height * 0.91, size.width * 0.75, size.height * 1.05, size.width * 0.68, size.height * 1.05);
        res.cubicTo(size.width * 0.61, size.height * 1.05, size.width * 0.59, size.height * 0.85, size.width * 0.55, size.height * 0.85);
        res.cubicTo(size.width / 2, size.height * 0.85, size.width * 0.48, size.height * 1.05, size.width * 0.41, size.height * 1.05);
        res.cubicTo(size.width * 0.41, size.height * 1.05, size.width * 0.41, size.height * 1.05, size.width * 0.41, size.height * 1.05);
        break;
      case EntryType.sleep:
        Size size = Size(92, 92);
        res.moveTo(size.width * 0.54, size.height * 0.04);
        res.cubicTo(size.width * 0.54, size.height * 0.04, size.width * 0.66, size.height * 0.42, size.width * 0.66, size.height * 0.42);
        res.cubicTo(size.width * 0.66, size.height * 0.42, size.width * 1.04, size.height * 0.42, size.width * 1.04, size.height * 0.42);
        res.cubicTo(size.width * 1.04, size.height * 0.42, size.width * 0.73, size.height * 0.66, size.width * 0.73, size.height * 0.66);
        res.cubicTo(size.width * 0.73, size.height * 0.66, size.width * 0.85, size.height * 1.04, size.width * 0.85, size.height * 1.04);
        res.cubicTo(size.width * 0.85, size.height * 1.04, size.width * 0.54, size.height * 0.8, size.width * 0.54, size.height * 0.8);
        res.cubicTo(size.width * 0.54, size.height * 0.8, size.width * 0.23, size.height * 1.04, size.width * 0.23, size.height * 1.04);
        res.cubicTo(size.width * 0.23, size.height * 1.04, size.width * 0.35, size.height * 0.66, size.width * 0.35, size.height * 0.66);
        res.cubicTo(size.width * 0.35, size.height * 0.66, size.width * 0.04, size.height * 0.42, size.width * 0.04, size.height * 0.42);
        res.cubicTo(size.width * 0.04, size.height * 0.42, size.width * 0.42, size.height * 0.42, size.width * 0.42, size.height * 0.42);
        res.cubicTo(size.width * 0.42, size.height * 0.42, size.width * 0.54, size.height * 0.04, size.width * 0.54, size.height * 0.04);
        res.cubicTo(size.width * 0.54, size.height * 0.04, size.width * 0.54, size.height * 0.04, size.width * 0.54, size.height * 0.04);
        break;
      case EntryType.finances:
        Size size = Size(95, 95);
        res.moveTo(size.width * 0.54, size.height * 0.04);
        res.cubicTo(size.width * 0.53, size.height * 0.04, size.width * 0.53, size.height * 0.04, size.width * 0.52, size.height * 0.04);
        res.cubicTo(size.width / 4, size.height * 0.05, size.width * 0.04, size.height * 0.27, size.width * 0.04, size.height * 0.54);
        res.cubicTo(size.width * 0.04, size.height * 0.82, size.width * 0.26, size.height * 1.04, size.width * 0.54, size.height * 1.04);
        res.cubicTo(size.width * 0.81, size.height * 1.04, size.width * 1.03, size.height * 0.83, size.width * 1.04, size.height * 0.56);
        res.cubicTo(size.width * 1.04, size.height * 0.55, size.width * 1.04, size.height * 0.55, size.width * 1.04, size.height * 0.54);
        res.cubicTo(size.width * 1.04, size.height * 0.54, size.width * 1.02, size.height * 0.54, size.width * 1.02, size.height * 0.54);
        res.cubicTo(size.width * 1.02, size.height * 0.54, size.width * 0.57, size.height * 0.54, size.width * 0.57, size.height * 0.54);
        res.cubicTo(size.width * 0.57, size.height * 0.54, size.width * 0.55, size.height * 0.54, size.width * 0.54, size.height * 0.54);
        res.cubicTo(size.width * 0.54, size.height * 0.53, size.width * 0.54, size.height * 0.51, size.width * 0.54, size.height * 0.51);
        res.cubicTo(size.width * 0.54, size.height * 0.51, size.width * 0.54, size.height * 0.06, size.width * 0.54, size.height * 0.06);
        res.cubicTo(size.width * 0.54, size.height * 0.06, size.width * 0.54, size.height * 0.05, size.width * 0.54, size.height * 0.04);
        res.cubicTo(size.width * 0.54, size.height * 0.04, size.width * 0.54, size.height * 0.04, size.width * 0.54, size.height * 0.04);
        break;
    }
    return res;
  }

  operator ==(covariant EntryType other) {
    return this.name == other.name;
  }
}


List<EntryType> allEntryTypes = [
  EntryType(EntryType.career),
  EntryType(EntryType.health),
  EntryType(EntryType.personality),
  EntryType(EntryType.friends),
  EntryType(EntryType.relationship),
  EntryType(EntryType.environment),
  EntryType(EntryType.sleep),
  EntryType(EntryType.finances),
];

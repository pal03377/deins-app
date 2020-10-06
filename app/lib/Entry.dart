import 'dart:ui';

import 'package:deins/EntryType.dart';


class Entry {
  DateTime creationDate;
  EntryType type;
  List<Offset> drawPoints;

  Entry(this.creationDate, this.type, this.drawPoints);
  Entry.noDrawing(this.creationDate, this.type) {
    this.drawPoints = List();
  }
  Entry.from(Entry entry) {
    this.creationDate = entry.creationDate;
    this.type = entry.type;
    this.drawPoints = entry.drawPoints;
  }
  Entry.fromData(Map<String, dynamic> data) {
    this.creationDate = DateTime.fromMillisecondsSinceEpoch(data["creationDate"]);
    this.type = EntryType.fromName(data["type"]);
    this.drawPoints = List<Offset>.from(data["drawPoints"].map((point) {
      if (point == null) return null;
      return Offset(point[0], point[1]);
    }));
  }

  clearDrawings() {
    drawPoints = [];
  }

  Map<String, dynamic> data() {
    Map<String, dynamic> data = Map<String, dynamic>();
    data["creationDate"] = creationDate.millisecondsSinceEpoch;
    data["type"] = type.name;
    List<List<double>> drawPointsSerialized = drawPoints.map((point) {
      if (point == null) return null;
      return [point.dx, point.dy];
    }).toList();
    data["drawPoints"] = drawPointsSerialized;
    return data;
  }

  bool operator ==(covariant Entry other) {
    return creationDate == other.creationDate;
  }

  int get hashCode {
    return creationDate.hashCode;
  }
}

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

  clearDrawings() {
    drawPoints = [];
  }

  bool operator ==(covariant Entry other) {
    return creationDate == other.creationDate;
  }

  int get hashCode {
    return creationDate.hashCode;
  }
}

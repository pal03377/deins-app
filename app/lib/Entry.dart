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

  clearDrawings() {
    drawPoints = [];
  }

}

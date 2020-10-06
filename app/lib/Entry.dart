import 'dart:ui';

import 'package:deins/EntryType.dart';


class Entry {
  DateTime creationDate;
  EntryType type;
  double percentage;
  List<Offset> drawPoints;

  Entry(this.creationDate, this.type, this.percentage, this.drawPoints);
  Entry.noDrawing(this.creationDate, this.type, this.percentage) {
    this.drawPoints = List();
  }

}

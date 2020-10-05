import 'package:deins/TouchPoint.dart';
import 'package:deins/EntryType.dart';


class Entry {
  DateTime creationDate;
  EntryType type;
  double percentage;
  List<TouchPoint> drawPoints;

  Entry(this.creationDate, this.type, this.percentage, this.drawPoints);
  Entry.noDrawing(this.creationDate, this.type, this.percentage) {
    this.drawPoints = List();
  }
}

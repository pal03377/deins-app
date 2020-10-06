import 'dart:math';
import 'dart:ui';

import 'package:deins/EntryType.dart';
import 'package:deins/entryDrawer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as image;


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

  Future<double> getPercentage() async {
    int calcDetailSize = 100;

    final bgPictureRecorder = PictureRecorder();
    final bgCanvas = Canvas(bgPictureRecorder);
    Paint backgroundPaint = new Paint()
      ..color = Colors.red;
    // draw background color such that it pretty much exactly behind the shape
    bgCanvas.drawPath(type.shape, backgroundPaint);
    Picture bgPicture = bgPictureRecorder.endRecording();
    ByteData bgImgData = await (await bgPicture.toImage(calcDetailSize, calcDetailSize)).toByteData();
    image.Image bgImg = image.Image.fromBytes(calcDetailSize, calcDetailSize, bgImgData.buffer.asUint8List().toList());
    int totalPixels = 0;
    for (int x = 0; x < calcDetailSize; x ++) {
      for (int y = 0; y < calcDetailSize; y ++) {
        int pixel = bgImg.getPixel(x, y);
        if (pixel > 0) totalPixels ++;
      }
    }

    final pictureRecorder = PictureRecorder();
    final canvas = Canvas(pictureRecorder);
    drawEntryOnCanvas(canvas, Size(calcDetailSize.toDouble(), calcDetailSize.toDouble()), this);
    Picture picture = pictureRecorder.endRecording();
    ByteData imgData = await (await picture.toImage(calcDetailSize, calcDetailSize)).toByteData();
    image.Image img = image.Image.fromBytes(calcDetailSize, calcDetailSize, imgData.buffer.asUint8List().toList());
    int coloredPixels = 0;
    for (int x = 0; x < calcDetailSize; x ++) {
      for (int y = 0; y < calcDetailSize; y ++) {
        int pixel = img.getPixel(x, y);
        if (pixel > 0) coloredPixels ++;
      }
    }
    if (totalPixels == 0) return 0.0;
    return min(1.0, coloredPixels / totalPixels);
  }

  bool operator ==(covariant Entry other) {
    return creationDate == other.creationDate;
  }

  int get hashCode {
    return creationDate.hashCode;
  }
}

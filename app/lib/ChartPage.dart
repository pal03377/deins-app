import 'package:deins/EntryChart.dart';
import 'package:deins/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBg,
      appBar: AppBar(
        title: Text("Charts.", style: TextStyle(fontFamily: GoogleFonts.getFont("Crimson Text").fontFamily, fontSize: 36)),
        centerTitle: true
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: EntryChart(),
      )
    );
  }
}

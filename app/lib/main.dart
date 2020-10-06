import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:deins/EntryType.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Timeline.dart';

final List<Entry> _entries = [
  Entry.noDrawing(new DateTime.utc(2020, 10, 3), EntryType(EntryType.career), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 10, 2), EntryType(EntryType.health), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 10, 2), EntryType(EntryType.self), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 29), EntryType(EntryType.friends), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 29), EntryType(EntryType.health), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 29), EntryType(EntryType.health), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 26), EntryType(EntryType.self), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 26), EntryType(EntryType.health), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 25), EntryType(EntryType.career), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 24), EntryType(EntryType.career), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 23), EntryType(EntryType.self), 0.5), 
  Entry.noDrawing(new DateTime.utc(2020, 9, 23), EntryType(EntryType.health), 0.5), 
];


void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(ChangeNotifierProvider(
    create: (context) => EntryModel.fromEntries(_entries),
    child: App()
  ));
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Deins',
        theme: ThemeData(
          primaryColor: Colors.black, 
          textTheme: GoogleFonts.crimsonTextTextTheme( Theme.of(context).textTheme )
        ),
      home: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(70.0), 
          child: AppBar(
            title: Text("Deins.", style: TextStyle(fontFamily: GoogleFonts.getFont("Crimson Text").fontFamily, fontSize: 36)),
            centerTitle: true
          )
        ), 
        body: Center(
          child: Timeline(),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add), 
          onPressed: () {},
          backgroundColor: Colors.black
        ),
        backgroundColor: Colors.white
      ),
    );
  }
}

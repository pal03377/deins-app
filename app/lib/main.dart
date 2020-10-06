import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:deins/EntryType.dart';
import 'package:deins/storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'Timeline.dart';


void main() {
  EntryModel eModel = EntryModel();
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(ChangeNotifierProvider.value(
    value: eModel,
    child: App()
  ));

  loadEntries().then((entries) => eModel.addAll(entries));
  eModel.addListener(() {
    storeEntries(eModel.entries);
  });
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
          onPressed: () {
            Provider.of<EntryModel>(context, listen: false).add(Entry.noDrawing(DateTime.now(), EntryType(EntryType.none)));
          },
          backgroundColor: Colors.black
        ),
        backgroundColor: Colors.white
      ),
    );
  }
}

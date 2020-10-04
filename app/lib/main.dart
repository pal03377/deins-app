import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Timeline.dart';

void main() {
  LicenseRegistry.addLicense(() async* {
    final license = await rootBundle.loadString('google_fonts/OFL.txt');
    yield LicenseEntryWithLineBreaks(['google_fonts'], license);
  });
  runApp(App());
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
        backgroundColor: Colors.white
      ),
    );
  }
}

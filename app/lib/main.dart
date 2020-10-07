import 'package:deins/ChartPage.dart';
import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:deins/EntryType.dart';
import 'package:deins/colors.dart';
import 'package:deins/requestEntryRemoval.dart';
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
    final license = await rootBundle.loadString('fonts/OFL.txt');
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
  _openCharts(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return ChartPage();
        }
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Deins',
      theme: ThemeData(
        primaryColor: primary,
        backgroundColor: whiteBg,
        textTheme: GoogleFonts.crimsonTextTextTheme( Theme.of(context).textTheme )
      ),
      home: Builder(
        builder: (context) => Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(70.0), 
            child: AppBar(
              title: Text("Deins.", style: TextStyle(fontFamily: GoogleFonts.getFont("Crimson Text").fontFamily, fontSize: 36)),
              actions: [
                IconButton(icon: Icon(Icons.info_outline), onPressed: () => showAboutDialog(
                  context: context,
                  children: [
                    Text("Deins is an app for you to track how you feel about different areas of your life - just by drawing into shapes. The more you draw, the happier you are. You can then get a chart about your developments. There is no syncing into the cloud, everything is kept private on your device.\n\n"),
                    Text("Impress:\nPaul Schwind\nWiesenweg 27\n97084 Würzburg\nGermany", style: TextStyle(color: Colors.black54)),
                    TextButton(child: Text("Remove all data"), onPressed: () { Navigator.of(context).pop(); requestEntryRemoval(context); })
                  ]
                )),
                IconButton(icon: Icon(Icons.stacked_line_chart_rounded), onPressed: () => _openCharts(context))
              ],
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
            backgroundColor: primary
          ),
          backgroundColor: whiteBg
        ),
      ),
    );
  }
}

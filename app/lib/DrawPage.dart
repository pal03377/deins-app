import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:deins/EntryType.dart';
import 'package:deins/EntryTypeSelectDialog.dart';
import 'package:deins/TypeDraw.dart';
import 'package:deins/colors.dart';
import 'package:deins/entryDatePicker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DrawPage extends StatelessWidget {
  final Entry _entry;
  DrawPage(this._entry);

  Future<void> _openEntryTypeSelectDialog(BuildContext context) async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      EntryType newType = EntryType(EntryType.none);
      while (newType.empty) {
        newType = await showDialog<EntryType>(
          context: context,
          builder: (BuildContext context) { return EntryTypeSelectDialog(); }
        );
        if (newType == null) newType = _entry.type;
      }
      if (newType != _entry.type) {
        _entry.type = newType;
        _entry.clearDrawings();
      }
      Provider.of<EntryModel>(context, listen: false).indicateChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_entry.type.empty) {
       _openEntryTypeSelectDialog(context);
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final textStyle = TextStyle(
      fontSize: screenWidth >= 500 ? 28 : 22
    );
    final drawSize = Size(screenWidth * 0.7, screenWidth * 0.7);
    final todayAtMidnight = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0, 0);
    final isToday = _entry.creationDate.isAfter(todayAtMidnight);

    return Consumer<EntryModel>(
      builder: (context, entryModel, child) {
        return Scaffold(
          backgroundColor: whiteBg,
          body: Stack(
            children: [
              Positioned(
                top: 24,
                right: 24,
                child: Opacity(
                  opacity: .75, 
                  child: IconButton(
                    icon: Icon(Icons.close, size: 32), 
                    onPressed: () { Navigator.pop(context); }
                  )
                )
              ), 
              Padding(
                padding: const EdgeInsets.only(top: 96, bottom: 48), 
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Column(
                        children: [
                          Text.rich(
                            TextSpan(
                              text: "Draw how you " + (isToday ? "feel" : "felt") + " \nabout your ", 
                              style: TextStyle(fontSize: (screenWidth >= 500 ? 36 : 28), height: 1.2),
                              children: [
                                TextSpan(
                                  text: _entry.type.name, 
                                  style: TextStyle(
                                    decoration: TextDecoration.underline
                                  ),
                                  recognizer: new TapGestureRecognizer()..onTap = () { _openEntryTypeSelectDialog(context); }
                                ), 
                                TextSpan(text: ".")
                              ]
                            ),
                            textAlign: TextAlign.center
                          ),
                          Text("more filled shape = better")
                        ],
                      )
                    ),
                    TypeDraw(entry: _entry, size: drawSize, disabled: false),
                    Padding(
                      padding: EdgeInsets.only(
                        left: (screenWidth >= 500 ? 32 : 8), 
                        right: (screenWidth >= 500 ? 32 : 8)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          SizedBox(
                            width: (screenWidth >= 500 ? 145 : 120), 
                            child: TextButton(
                              child: Text(
                                _entry.creationDate.year.toString() + "-" + 
                                _entry.creationDate.month.toString().padLeft(2, "0") + "-" + 
                                _entry.creationDate.day.toString().padLeft(2, "0"),
                                style: textStyle,
                                textAlign: TextAlign.right
                              ),
                              onPressed: () {
                                showEntryDatePicker(context, _entry);
                              },
                              style: TextButton.styleFrom(primary: primary)
                            )
                          ),
                          MaterialButton(
                            child: Text("done", style: TextStyle(color: Colors.white, fontSize: 25)),
                            onPressed: () { Navigator.pop(context); },
                            color: primary,
                            shape: CircleBorder(),
                            minWidth: 80,
                            height: 80,
                            elevation: 4.0,
                          ),
                          SizedBox(
                            width: (screenWidth >= 500 ? 145 : 120),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: IconButton(
                                icon: Icon(_entry.drawPoints.length > 0 ? Icons.replay : Icons.delete_outline, size: (screenWidth >= 500 ? 32 : 28)), 
                                onPressed: () {
                                  if (_entry.drawPoints.length > 0) {
                                    _entry.clearDrawings();
                                    Provider.of<EntryModel>(context, listen: false).indicateChange();
                                  } else {
                                    Provider.of<EntryModel>(context, listen: false).remove(_entry);
                                    Navigator.pop(context);
                                  }
                                }
                              )
                            )
                          )
                        ],
                      ),
                    )
                  ]
                )
              ),
            ],
          )
        );
      }
    );
  }
}

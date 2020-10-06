import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:deins/EntryType.dart';
import 'package:deins/EntryTypeSelectDialog.dart';
import 'package:deins/TypeDraw.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class DrawPage extends StatefulWidget {
  final Entry _entry;
  DrawPage(this._entry);

  @override
  _DrawPageState createState() => _DrawPageState(_entry);
}

class _DrawPageState extends State<DrawPage> {
  Entry _entry;
  _DrawPageState(this._entry);

  Future<void> _openEntryTypeSelectDialog() async {
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
        setState(() {
          _entry.type = newType;
          _entry.clearDrawings();
        });
      }
      Provider.of<EntryModel>(context, listen: false).indicateChange();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_entry.type.empty) {
       _openEntryTypeSelectDialog();
    }
    final screenWidth = MediaQuery.of(context).size.width;
    final drawSize = Size(screenWidth * 0.7, screenWidth * 0.7);
    return Scaffold(
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
            padding: const EdgeInsets.only(top: 96, bottom: 96), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Text.rich(
                    TextSpan(
                      text: "Draw how you feel \nabout your ", 
                      style: TextStyle(fontSize: 36, height: 1.2),
                        children: [
                          TextSpan(
                            text: _entry.type.name, 
                            style: TextStyle(
                              decoration: TextDecoration.underline
                            ),
                            recognizer: new TapGestureRecognizer()..onTap = () { setState(() { _openEntryTypeSelectDialog(); }); }
                          ), 
                          TextSpan(text: ".")
                        ]
                    ),
                    textAlign: TextAlign.center
                  )
                ),
                TypeDraw(entry: _entry, size: drawSize, disabled: false)
              ]
            )
          )
        ],
      )
    );
  }
}

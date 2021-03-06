import 'package:deins/Entry.dart';
import 'package:deins/EntryType.dart';
import 'package:deins/TypeDraw.dart';
import 'package:flutter/material.dart';

class EntryTypeSelectDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SimpleDialogOption> buttons = [];
    for (EntryType et in allEntryTypes) {
      buttons.add(SimpleDialogOption(
        onPressed: () { Navigator.pop(context, et); },
        child: Row(
          children: [
            TypeDraw(entry: Entry.noDrawing(DateTime.now(), et), size: Size(36, 36), disabled: true, fillColors: et.colors), 
            Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Text(et.name, style: TextStyle(fontSize: 20))
            )
          ]
        )
      ));
    }

    return SimpleDialog(
      title: const Text('Select type'),
      children: buttons
    );
  }
}

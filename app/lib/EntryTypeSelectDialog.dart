import 'package:deins/EntryType.dart';
import 'package:flutter/material.dart';

class EntryTypeSelectDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<SimpleDialogOption> buttons = [];
    for (EntryType et in allEntryTypes) {
      buttons.add(SimpleDialogOption(
        onPressed: () { Navigator.pop(context, et); },
        child: Text(et.name)
      ));
    }

    return SimpleDialog(
      title: const Text('Select type'),
      children: buttons
    );
  }
}

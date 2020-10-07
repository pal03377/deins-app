import 'package:deins/EntryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


requestEntryRemoval(BuildContext context) {
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Remove Everything", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
    onPressed: () async {
      final prefs = await SharedPreferences.getInstance();
      prefs.remove("entries");
      Provider.of<EntryModel>(context, listen: false).removeAll();
      Navigator.of(context).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    title: Text("Clear all data"),
    content: Text("Remove all paintings from the app? (Cannot be undone!)"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

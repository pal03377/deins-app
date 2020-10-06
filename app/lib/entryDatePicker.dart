import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


showEntryDatePicker(BuildContext context, Entry entry) async {
  DateTime lastDate = DateTime.now();
  if (lastDate.isBefore(entry.creationDate)) {
    lastDate = entry.creationDate;
  }
  DateTime date = await showDatePicker(
    context: context, 
    initialDate: entry.creationDate, 
    firstDate: DateTime.parse("2000-01-01"), 
    lastDate: lastDate
  );
  if (date != null) {
    entry.creationDate = date;
    Provider.of<EntryModel>(context, listen: false).indicateChange();
  }
}

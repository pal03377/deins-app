import 'package:flutter/foundation.dart';
import 'package:deins/Entry.dart';


class EntryListModel extends ChangeNotifier {

  List<Entry> entries = [];

  EntryListModel();
  EntryListModel.fromEntries(this.entries);

  void add(Entry entry) {
    entries.add(entry);
    indicateChange();
  }

  void addAll(List<Entry> entries) {
    this.entries.addAll(entries);
    indicateChange();
  }

  void remove(Entry entry) {
    this.entries.remove(entry);
    indicateChange();
  }

  void removeAll() {
    this.entries = [];
    indicateChange();
  }

  void indicateChange() {
    entries.sort((a, b) {
      return a.creationDate.compareTo(b.creationDate);
    });
    notifyListeners();
  }
  
}

import 'package:flutter/foundation.dart';
import 'package:deins/Entry.dart';


class EntryModel extends ChangeNotifier {

  List<Entry> entries = [];

  EntryModel();
  EntryModel.fromEntries(this.entries);

  void add(Entry entry) {
    entries.add(entry);
    notifyListeners();
  }

  void addAll(List<Entry> entries) {
    this.entries.addAll(entries);
    notifyListeners();
  }

  void remove(Entry entry) {
    this.entries.remove(entry);
    notifyListeners();
  }

  void indicateChange() {
    notifyListeners();
  }
  
}

import 'package:flutter/foundation.dart';
import 'package:deins/Entry.dart';


class EntryModel extends ChangeNotifier {

  final List<Entry> entries;

  EntryModel.fromEntries(this.entries);

  void add(Entry entry) {
    entries.add(entry);
    notifyListeners();
  }

  void indicateChange() {
    notifyListeners();
  }
  
}

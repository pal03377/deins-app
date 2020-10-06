import 'package:flutter/foundation.dart';
import 'package:deins/Entry.dart';


class EntryModel extends ChangeNotifier {

  List<Entry> entries;

  EntryModel.fromEntries(this.entries);

  void add(Entry entry) {
    entries.add(entry);
    notifyListeners();
  }

  void remove(Entry entry) {
    print(entries.remove(entry));
    print(entries.map((e) => e.type.name));
    notifyListeners();
  }

  void indicateChange() {
    notifyListeners();
  }
  
}

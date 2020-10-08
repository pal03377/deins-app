import 'package:flutter/foundation.dart';
import 'package:deins/Entry.dart';


class EntryModel extends ChangeNotifier {

  Entry entry;

  EntryModel();
  EntryModel.fromEntry(this.entry);

  void indicateChange() {
    notifyListeners();
  }
  
}

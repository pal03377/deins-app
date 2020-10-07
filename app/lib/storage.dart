import 'dart:convert';

import 'package:deins/Entry.dart';
import 'package:shared_preferences/shared_preferences.dart';

storeEntries(List<Entry> entries) async {
  final prefs = await SharedPreferences.getInstance();
  List<String> jsonEntries = entries.map((entry) => jsonEncode(entry.data())).toList();
  prefs.setStringList("entries", jsonEntries);
}


Future<List<Entry>> loadEntries() async {
  final prefs = await SharedPreferences.getInstance();
  List<Entry> result = prefs.getStringList("entries")?.map((entryStr) {
    Map <String, dynamic> data = jsonDecode(entryStr);
    return Entry.fromData(data);
  })?.toList();
  if (result == null) return [];
  result.sort((a, b) {
    return a.creationDate.compareTo(b.creationDate);
  });
  return result;
}

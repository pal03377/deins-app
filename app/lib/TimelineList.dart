import 'package:deins/DrawPage.dart';
import 'package:deins/Entry.dart';
import 'package:deins/EntryType.dart';
import 'package:flutter/material.dart';


class TimelineList extends StatefulWidget {
  final List<Entry> _entries = [
    Entry.noDrawing(new DateTime.utc(2020, 10, 3), EntryType(EntryType.career), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 10, 2), EntryType(EntryType.health), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 10, 2), EntryType(EntryType.personality), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 29), EntryType(EntryType.friends), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 29), EntryType(EntryType.health), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 29), EntryType(EntryType.health), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 26), EntryType(EntryType.personality), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 26), EntryType(EntryType.health), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 25), EntryType(EntryType.career), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 24), EntryType(EntryType.career), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 23), EntryType(EntryType.personality), 0.5), 
    Entry.noDrawing(new DateTime.utc(2020, 9, 23), EntryType(EntryType.health), 0.5), 
  ];

  @override
  _TimelineListState createState() => _TimelineListState(_entries);
}


class _TimelineListState extends State<TimelineList> {
  var _allEntries;
  _TimelineListState(this._allEntries);
  final _entries = <Entry>[];

  Widget _buildRow(entry) {
    final textStyle = TextStyle(
      fontSize: 28
    );
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: .75,
            child: SizedBox(
              width: 150, 
              child: Text(
                entry.creationDate.year.toString() + "-" + 
                entry.creationDate.month.toString() + "-" + 
                entry.creationDate.day.toString(), 
                style: textStyle, 
                textAlign: TextAlign.right
              )
            )
          ), 
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16), 
            child: Image.asset(
              "img/types/" + entry.type.name + ".png", 
              width: 85, 
              height: 85
            )
          ), 
          Opacity(
            opacity: .75,
            child: SizedBox(
              width: 150, 
              child: Text(entry.type.name, style: textStyle)
            )
          )
        ]
      ),
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            // NEW lines from here...
            builder: (BuildContext context) {
              return DrawPage(entry);
            }
          ),
        );
      }
    );
  }

  Widget _buildEntries() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: _allEntries.length, 
      itemBuilder: (context, index) {
        if (index >= _allEntries.length) return null;
        if (index >= _entries.length && _entries.length < _allEntries.length) {
          int rangeEnd = _entries.length + 10;
          if (rangeEnd >= _allEntries.length) rangeEnd = _allEntries.length;
          _entries.addAll(_allEntries.sublist(
            _entries.length, rangeEnd
          ));
        }
        return _buildRow(_entries[index]);
      }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 32), 
      child: _buildEntries()
    );
  }
}

import 'package:deins/DrawPage.dart';
import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:deins/TypeDraw.dart';
import 'package:deins/entryDatePicker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class TimelineList extends StatefulWidget {
  @override
  _TimelineListState createState() => _TimelineListState();
}


class _TimelineListState extends State<TimelineList> {
  _TimelineListState();
  List<Entry> _entries = [];

  _openEntry(BuildContext context, Entry entry) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          return DrawPage(entry);
        }
      )
    );
  }

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
              width: 145, 
              child: TextButton(
                child: Text(
                  entry.creationDate.year.toString() + "-" + 
                  entry.creationDate.month.toString() + "-" + 
                  entry.creationDate.day.toString(),
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.right
                ),
                onPressed: () {
                  showEntryDatePicker(context, entry);
                },
                style: TextButton.styleFrom(primary: Colors.black)
              )
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 8),
            child: TypeDraw(entry: entry, size: Size(75, 75), disabled: true)
          ),
          Opacity(
            opacity: .75,
            child: SizedBox(
              width: 145, 
              child: Text(entry.type.name, style: textStyle)
            )
          )
        ]
      ),
      onTap: () {
        _openEntry(context, entry);
      }
    );
  }

  Widget _buildEntries() {
    return Consumer<EntryModel>(
      builder: (context, entryModel, child) {
        List<Entry> allEntries = entryModel.entries;
        for (Entry entry in allEntries) {
          if (entry.type.empty) {
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              _openEntry(context, entry);
            });
            break;
          }
        }
        _entries = [];
        return ListView.builder(
          reverse: true,
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: allEntries.length, 
          itemBuilder: (context, index) {
            if (index >= allEntries.length) return null;
            if (index >= _entries.length && _entries.length < allEntries.length) {
              int rangeEnd = _entries.length + 10;
              if (rangeEnd >= allEntries.length) rangeEnd = allEntries.length;
              _entries.addAll(allEntries.sublist(
                _entries.length, rangeEnd
              ));
            }
            return _buildRow(_entries[index]);
          }
        );
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

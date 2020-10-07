import 'package:deins/DrawPage.dart';
import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:deins/TypeDraw.dart';
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
    final double screenWidth = MediaQuery.of(context).size.width;
    final textStyle = TextStyle(
      fontSize: screenWidth >= 500 ? 28 : 22
    );
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Opacity(
            opacity: .75,
            child: SizedBox(
              width: screenWidth >= 500 ? 145 : 116, 
              child: Text(
                entry.creationDate.year.toString() + "-" + 
                entry.creationDate.month.toString().padLeft(2, "0") + "-" + 
                entry.creationDate.day.toString().padLeft(2, "0"),
                style: textStyle,
                textAlign: TextAlign.right,
                softWrap: false
              )
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              left: (screenWidth >= 500 ? 16 : 6),
              right: (screenWidth >= 500 ? 16 : 6),
              top: 8,
              bottom: 8
            ),
            child: TypeDraw(entry: entry, size: Size(75, 75), disabled: true)
          ),
          Opacity(
            opacity: .75,
            child: SizedBox(
              width: screenWidth >= 500 ? 145 : 116, 
              child: Text(entry.type.name, style: textStyle, softWrap: false)
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

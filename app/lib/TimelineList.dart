import 'dart:math';

import 'package:deins/Entry.dart';
import 'package:flutter/material.dart';


class TimelineList extends StatefulWidget {
  final List<Entry> _entries = [
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
    Entry(DateTime(0), "test", 0.5), 
  ];

  @override
  _TimelineListState createState() => _TimelineListState(_entries);
}


class _TimelineListState extends State<TimelineList> {
  var _allEntries;
  _TimelineListState(this._allEntries);
  final _entries = <Entry>[];

  Widget _buildRow(entry) {
    return ListTile(
      title: Text(
        entry.type
      ),
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
    return _buildEntries();
  }
}

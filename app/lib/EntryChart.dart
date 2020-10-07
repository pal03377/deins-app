import 'package:deins/Entry.dart';
import 'package:deins/EntryModel.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:deins/EntryType.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class EntryWithCachedPercentage extends Entry {
  double _cachedPercentage;

  EntryWithCachedPercentage.from(Entry entry) : super.from(entry);
  
  Future<void> calculateAndCachePercentage() async {
    _cachedPercentage = await this.getPercentage();
  }

  get percentage {
    return _cachedPercentage;
  }
}

class EntryChart extends StatelessWidget {
  Future<List<charts.Series<EntryWithCachedPercentage, DateTime>>> _createData(entryModel) async {

    // prepare percentage
    List<EntryWithCachedPercentage> cachedEntries = [];
    for (Entry e in entryModel.entries) {
      EntryWithCachedPercentage entry = EntryWithCachedPercentage.from(e);
      await entry.calculateAndCachePercentage();
      cachedEntries.add(entry);
    }

    List<charts.Series<EntryWithCachedPercentage, DateTime>> entryTypeCharts = [];
    for (EntryType et in allEntryTypes) {
      entryTypeCharts.add(
        new charts.Series<EntryWithCachedPercentage, DateTime>(
          id: et.name,
          colorFn: (_, __) => charts.ColorUtil.fromDartColor(et.colors[0]),
          domainFn: (EntryWithCachedPercentage entry, _) => entry.creationDate,
          measureFn: (EntryWithCachedPercentage entry, _) => entry.percentage * 100,
          data: cachedEntries.where((entry) => entry.type == et).toList(),
        )
      );
    }

    return entryTypeCharts;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<EntryModel>(
      builder: (context, entryModel, child) {
        return FutureBuilder(
          future: _createData(entryModel),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return charts.TimeSeriesChart(
                snapshot.data,
                animate: true,
                // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                // should create the same type of [DateTime] as the data provided. If none
                // specified, the default creates local date time.
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                behaviors: [new charts.SeriesLegend()]
              );
            } else {
              return CircularProgressIndicator();
            }
          }
        );
      }
    );
  }
}

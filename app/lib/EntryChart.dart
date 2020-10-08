import 'package:deins/Entry.dart';
import 'package:deins/EntryListModel.dart';
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
  Future<List<charts.Series<EntryWithCachedPercentage, DateTime>>> _createData(entryListModel) async {

    // prepare percentage
    List<EntryWithCachedPercentage> cachedEntries = [];
    for (Entry e in entryListModel.entries) {
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
    return Consumer<EntryListModel>(
      builder: (context, entryListModel, child) {
        return FutureBuilder(
          future: _createData(entryListModel),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return charts.TimeSeriesChart(
                snapshot.data,
                animate: true,
                // Optionally pass in a [DateTimeFactory] used by the chart. The factory
                // should create the same type of [DateTime] as the data provided. If none
                // specified, the default creates local date time.
                dateTimeFactory: const charts.LocalDateTimeFactory(),
                behaviors: [
                  new charts.SlidingViewport(),
                  new charts.PanAndZoomBehavior(),
                  new charts.SeriesLegend(),
                  new charts.ChartTitle("Your feelings over time",
                      subTitle: "This shows fill percentages of shapes over time." + (entryListModel.entries.length <= 3 ? "\nCheck back later to see something here." : ""),
                      behaviorPosition: charts.BehaviorPosition.top,
                      titleOutsideJustification: charts.OutsideJustification.start,
                      innerPadding: 18),
                  new charts.ChartTitle("Fill percentage",
                    behaviorPosition: charts.BehaviorPosition.start,
                    titleOutsideJustification:
                        charts.OutsideJustification.middleDrawArea)
                ]
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

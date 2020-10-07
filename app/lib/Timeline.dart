import 'package:deins/EntryModel.dart';
import 'package:deins/TimelineList.dart';
import 'package:deins/colors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class Timeline extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32), 
              child: Text("today", style: TextStyle(fontSize: 28))
            ), 
            Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 12, bottom: 64), 
                  child: Center(
                    child: Container(
                      child: Consumer<EntryModel>(
                        builder: (context, entryModel, child) {
                          return SizedBox(
                            width: 6,
                            height: entryModel.entries.length * 100.0 + 32
                          );
                      }),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(3)
                      )
                    )
                  )
                ),
                TimelineList()
              ],
            )
          ]
        )
      ]
    );
  }
}

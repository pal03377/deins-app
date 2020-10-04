import 'package:deins/TimelineList.dart';
import 'package:flutter/material.dart';


class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 32), 
      child: ListView(
        shrinkWrap: true,
        children: [
          Text("today", style: TextStyle(fontSize: 28)), 
          Padding(
            padding: EdgeInsets.only(top: 12), 
            child: Container(
              child: SizedBox(
                width: 6, 
                height: 100
              ),
              decoration: BoxDecoration(
                color: Colors.black, 
                borderRadius: BorderRadius.circular(3)
              )
            )
          ),
          TimelineList()
        ]
      )
    );
  }
}

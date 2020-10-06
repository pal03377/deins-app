import 'package:deins/TimelineList.dart';
import 'package:flutter/material.dart';


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
                  padding: const EdgeInsets.only(top: 12), 
                  child: Center(
                    child: Container(
                      child: SizedBox(
                        width: 6, 
                        height: 10000
                      ),
                      decoration: BoxDecoration(
                        color: Colors.black, 
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

import 'package:deins/Entry.dart';
import 'package:deins/TypeDraw.dart';
import 'package:flutter/material.dart';


class DrawPage extends StatelessWidget {
  final Entry _entry;
  DrawPage(this._entry);

  @override
  Widget build(BuildContext context) {
    print("entry");
    print(_entry);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 24,
            right: 24,
            child: Opacity(opacity: .75, child: Icon(Icons.close, size: 32))
          ), 
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 96),
                child: Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Draw how you feel \nabout your ", 
                      style: TextStyle(fontSize: 36, height: 1.2),
                       children: [
                         TextSpan(
                           text: "career", 
                           style: TextStyle(
                             decoration: TextDecoration.underline
                           )
                         ), 
                         TextSpan(text: ".")
                       ]
                    )                    
                  )
                ),
              ), 
              TypeDraw(_entry)
            ]
          )
        ],
      )
    );
  }
}

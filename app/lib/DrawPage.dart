import 'package:deins/Entry.dart';
import 'package:deins/TypeDraw.dart';
import 'package:flutter/material.dart';


class DrawPage extends StatefulWidget {
  final Entry _entry;
  DrawPage(this._entry);

  @override
  _DrawPageState createState() => _DrawPageState(_entry);
}

class _DrawPageState extends State<DrawPage> {
  Entry _entry;
  _DrawPageState(this._entry);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final drawSize = Size(screenWidth * 0.7, screenWidth * 0.7);
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 24,
            right: 24,
            child: Opacity(
              opacity: .75, 
              child: IconButton(
                icon: Icon(Icons.close, size: 32), 
                onPressed: () { Navigator.pop(context); }
              )
            )
          ), 
          Padding(
            padding: const EdgeInsets.only(top: 96, bottom: 96), 
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Draw how you feel \nabout your ", 
                      style: TextStyle(fontSize: 36, height: 1.2),
                        children: [
                          TextSpan(
                            text: _entry.type.name, 
                            style: TextStyle(
                              decoration: TextDecoration.underline
                            )
                          ), 
                          TextSpan(text: ".")
                        ]
                    )
                  )
                ),
                TypeDraw(_entry, drawSize, false)
              ]
            )
          )
        ],
      )
    );
  }
}

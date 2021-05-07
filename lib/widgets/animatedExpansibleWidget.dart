import 'dart:async';

import 'package:flutter/material.dart';

class AnimatedExpansible extends StatefulWidget {
  final Widget body;
  final Widget title;

  AnimatedExpansible({Key key, this.body, this.title}) : super(key: key);

  @override
  _AnimatedExpansibleState createState() => _AnimatedExpansibleState();
}

class _AnimatedExpansibleState extends State<AnimatedExpansible>
    with TickerProviderStateMixin {
  bool isHeightOpen = false;
  bool isWidthOpen = false;
  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      vsync: this,
      duration:  Duration(milliseconds: 700),
      curve: Curves.easeInOutBack,
      child: Card(
              child: Container(
                padding: EdgeInsets.all(5),
                child: Column(
          crossAxisAlignment: isWidthOpen
                ? CrossAxisAlignment.stretch
                : CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
          children: [
            isWidthOpen
                ?  Center(child: widget.title,):widget.title ,
            if (isHeightOpen) widget.body,
            GestureDetector(
                  onTap: () async {
                    if (isWidthOpen) {
                      setState(() {
                        isHeightOpen = false;
                      });

                      Timer(Duration(milliseconds: 750), () {
                        setState(() {
                          isWidthOpen = false;
                        });
                      });
                    } else {
                      setState(() {
                        isWidthOpen = true;
                      });

                      Timer(Duration(milliseconds: 750), () {
                        setState(() {
                          isHeightOpen = true;
                        });
                      });
                    }
                  },
                  child:
                      Icon(isWidthOpen ? Icons.arrow_upward : Icons.arrow_downward))
          ],
        ),
              ),
      ),
    );
  }
}

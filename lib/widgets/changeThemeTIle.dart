import 'package:flutter/material.dart';

class ChangeThemeTitle extends StatelessWidget {
  final String titleText;
  final String titleImage;
  const ChangeThemeTitle({Key key, this.titleText, this.titleImage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
                  Expanded(child: Text(titleText)),
                   Container(
                      height: 40,
                      width: 40,
                      margin: EdgeInsets.only(left:5),
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(
                        titleImage,
                        
                      ))),
                    ),
                    Spacer()
                  
                ]);
  }
}
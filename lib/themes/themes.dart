import 'package:flutter/material.dart';

class AppThemes {


  static ThemeData getLightTheme(){
    return ThemeData.light().copyWith(
      primaryColor: Color(0xFF004643),
      cardColor: Color(0xf057A773),
      
    );
  }

  static ThemeData getDarkTheme(){
    return ThemeData.dark();
  }

  static ThemeData getCaramelTheme(){
    return ThemeData.dark().copyWith(
      primaryColor: Color(0xFFca9e7a),
      backgroundColor: Color(0xFF87644B),
      canvasColor: Color(0xFF87644B),
      scaffoldBackgroundColor: Color(0xFF87644B),
      cardColor: Color(0xFFca9e7a),
      primaryColorLight: Color(0xFF837469),
      primaryColorDark: Color(0xFF87644B)
    );
  }

}
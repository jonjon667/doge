import 'package:doge/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppThemeController extends GetxController{
  final selectedTheme = AppThemes.getCaramelTheme().obs;

  void changeTheme(ThemeData newTheme){
    Get.changeTheme(newTheme);
    selectedTheme.value = newTheme;
  }
}
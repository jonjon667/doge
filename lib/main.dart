import 'package:doge/controllers/AppThemeController.dart';
import 'package:doge/themes/themes.dart';
import 'package:doge/views/home.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(DogeApp());
}

class DogeApp extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Get.put(AppThemeController());

    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: Get.find<AppThemeController>().selectedTheme.value,
     
      home: HomePage(),
    );
  }
}


import 'package:doge/controllers/AppThemeController.dart';
import 'package:doge/themes/themes.dart';
import 'package:doge/widgets/changeThemeTIle.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BaseScreen extends StatefulWidget {
  final Widget body;
  BaseScreen({Key key, this.body}) : super(key: key);

  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        child: Obx(
          () => ListView(
            children: [
              DrawerHeader(
                child: Image.asset("lib/assets/Doge-Branco-10pt-traçado.png"),
              ),
              Center(child: Text("Esquema de cor")),
              RadioListTile(
                value: AppThemes.getCaramelTheme(),
                groupValue: Get.find<AppThemeController>().selectedTheme.value,
                onChanged: (value) => setState(() {
                  Get.find<AppThemeController>().changeTheme(value);
                }),
                
                title: ChangeThemeTitle(titleText: "Caramelo",titleImage: 'lib/assets/CARAMELO.png',)
              ),
              RadioListTile(
                value: AppThemes.getDarkTheme(),
                groupValue: Get.find<AppThemeController>().selectedTheme.value,
                onChanged: (value) => setState(() {
                  Get.find<AppThemeController>().changeTheme(value);
                }),
                title:
                
                ChangeThemeTitle(titleText:'Escuro',titleImage: 'lib/assets/pretim.png',)
              ),
              RadioListTile(
                value: AppThemes.getLightTheme(),
                groupValue: Get.find<AppThemeController>().selectedTheme.value,
                onChanged: (value) {
                  setState(() {
                    Get.find<AppThemeController>().changeTheme(value);
                  });
                },
                title: ChangeThemeTitle(titleText: 'Claro',titleImage: 'lib/assets/brankim.png',)
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Doge",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
      ),
      body: widget.body,
    ));
  }
}

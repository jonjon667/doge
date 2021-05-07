import 'package:doge/controllers/AppThemeController.dart';
import 'package:doge/controllers/homeController.dart';
import 'package:doge/themes/themes.dart';
import 'package:doge/views/imageList.dart';
import 'package:doge/widgets/baseScreen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  HomeController controller = HomeController();
  @override
  void initState() {
    controller.fetchBreedList();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      body: Center(
          child: Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Obx(
          () => Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: Center(
                    child: Image.asset(Get.find<AppThemeController>().selectedTheme.value ==
                            AppThemes.getCaramelTheme()
                        ? 'lib/assets/CARAMELO.png'
                        : Get.find<AppThemeController>().selectedTheme.value ==
                                AppThemes.getLightTheme()
                            ? 'lib/assets/brankim.png'
                            : 'lib/assets/pretim.png'),
                  )),
              Text("Selecione a raça do doguinho",style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),),
              Expanded(
                child: controller.failLoading.value
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                            Image.asset(
                              'lib/assets/confuseDog.png',
                              width: MediaQuery.of(context).size.width * 0.8,
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 5),
                                child: Text("Erro ao buscar as raças D=")),
                            ElevatedButton(
                                onPressed: () {
                                  controller.fetchBreedList();
                                },
                                child: Text("Tentar novamente")),
                          ])
                    : controller.isLoading.value
                        ? Container(
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  CircularProgressIndicator(
                                    backgroundColor: Get.theme.primaryColor,
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Get.theme.primaryColorLight),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(top: 5),
                                      child: Text("Carregando raças..."))
                                ]),
                          )
                        : GridView.count(
                            crossAxisCount: 3,
                            childAspectRatio: 1.3,
                            children: controller.breedList
                                .map((breed) => GestureDetector(
                                      onTap: () {
                                        Get.to(() => ImageListPage(
                                              dogBreed: breed,
                                            ));
                                      },
                                      child: Card(
                                        child: Center(child: Text(breed.name)),
                                      ),
                                    ))
                                .toList(),
                          ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}

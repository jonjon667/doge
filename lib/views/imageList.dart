import 'package:doge/controllers/imgListController.dart';
import 'package:doge/models/breedModel.dart';
import 'package:doge/widgets/animatedExpansibleWidget.dart';
import 'package:doge/widgets/baseScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:share/share.dart';

class ImageListPage extends StatefulWidget {
  final Breed dogBreed;
  ImageListPage({Key key, this.dogBreed}) : super(key: key);

  @override
  _ImageListPageState createState() => _ImageListPageState();
}

class _ImageListPageState extends State<ImageListPage> {
  int numberOfImages = 10;
  String selectedOption = '';
  int listViewPage = 0;
  ImgListController controller;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    controller = ImgListController(widget.dogBreed);
    controller.fetchUrls(subBreed: selectedOption);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          if ((numberOfImages + listViewPage * numberOfImages) <
              controller.imageUrls.length) listViewPage++;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
        body: Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.only(top: 10, right: 10, left: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(bottom: 5),
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: GestureDetector(
                          onTap: () => Get.back(),
                          child: Icon(Icons.arrow_back),
                        ),
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.dogBreed.name,
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                AnimatedExpansible(
                  title: Text("Filtrar sub-raça"),
                  body: Wrap(
                      direction: Axis.horizontal,
                      children: <Widget>[
                            Container(
                              width: 130,
                              child: Card(
                                  child: Container(
                                child: Row(children: [
                                  Radio(
                                    value: '',
                                    groupValue: selectedOption,
                                    onChanged: (value) {
                                      setState(() {
                                        selectedOption = value;
                                        listViewPage = 0;
                                      });
                                      controller.fetchUrls(subBreed: value);
                                    },
                                  ),
                                  Text('Nenhuma'),
                                ]),
                              )),
                            )
                          ] +
                          widget.dogBreed.subBreeds
                              .map((name) => Container(
                                    width: 130,
                                    child: Card(
                                        child: Container(
                                      child: Row(children: [
                                        Radio(
                                          value: name,
                                          groupValue: selectedOption,
                                          onChanged: (value) {
                                            print(value);
                                            setState(() {
                                              selectedOption = value;
                                              listViewPage = 0;
                                            });
                                            controller.fetchUrls(
                                                subBreed: value);
                                          },
                                        ),
                                        Expanded(
                                            child: Text(
                                          name,
                                        )),
                                      ]),
                                    )),
                                  ))
                              .toList()),
                ),
                Obx(
                  () => Expanded(
                    child: controller.isLoading.value
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
                                      child: Text("Carregando imagens..."))
                                ]),
                          )
                        : Scrollbar(
                            child: StaggeredGridView.countBuilder(
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) =>
                                  GestureDetector(
                                onLongPress: () {
                                  Share.share(controller.imageUrls[index],
                                      subject:
                                          'Olha esse doguinho fofo que achei no doge!');
                                },
                                child: Container(
                                  child: Image.network(
                                    controller.imageUrls[index],
                                    errorBuilder: (BuildContext context,
                                        Object exception,
                                        StackTrace stackTrace) {
                                      return Container(
                                          child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                            Image.asset(
                                              'lib/assets/confuseDog.png',
                                            ),
                                            Container(
                                                margin: EdgeInsets.only(top: 5),
                                                child: Text(
                                                    "Erro ao visualizar imagem")),
                                          ]));
                                    },
                                    loadingBuilder: (BuildContext context,
                                        Widget child,
                                        ImageChunkEvent loadingProgress) {
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Container(
                                        height: 120,
                                        width: 120,
                                        child: Container(
                                          height: 20,
                                          width: 20,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes
                                                  : null,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              itemCount: (numberOfImages +
                                          listViewPage * numberOfImages) >
                                      controller.imageUrls.length
                                  ? controller.imageUrls.length
                                  : (numberOfImages +
                                      listViewPage * numberOfImages),
                              crossAxisCount: 2,
                              controller: scrollController,
                              staggeredTileBuilder: (int index) =>
                                  StaggeredTile.fit(1),
                              mainAxisSpacing: 4,
                              crossAxisSpacing: 4,
                            ),
                          ),
                  ),
                )
              ],
            )));
  }
}

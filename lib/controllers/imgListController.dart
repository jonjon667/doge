import 'dart:convert';

import 'package:doge/constants.dart';
import 'package:doge/models/breedModel.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class ImgListController {
  Breed dogBreed;
  final imageUrls = <String>[].obs;
  final isLoading = false.obs;
  final failLoading = false.obs;
  ImgListController(this.dogBreed);

  void fetchUrls({String subBreed}) async {
    isLoading.value = true;
    String subBreedUriString = subBreed.length>0? '/' + subBreed : '';
    print(Constants.BREED_IMAGES_API_URI  + dogBreed.name + subBreedUriString+ '/images');
    var url = Uri.parse(Constants.BREED_IMAGES_API_URI + dogBreed.name + subBreedUriString + '/images');
    var response = await http.get(url);
    var json = jsonDecode(response.body);
    imageUrls.assignAll(List<String>.from(json["message"].map((x) => x)));
    isLoading.value = false;
    
  }
}

import 'package:doge/constants.dart';
import 'package:doge/models/breedModel.dart';
import 'package:get/state_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomeController extends GetxController {
  final breedList = <Breed>[].obs;
  final isLoading = false.obs;
  final failLoading = false.obs;
  void fetchBreedList() async {
    isLoading.value = true;
    failLoading.value = false;
    try {
      var url = Uri.parse(Constants.BREED_LIST_API_URI);
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      print(json["message"].runtimeType);
      Map<String, List> allBreedsMap = Map<String, List>.from(json["message"]);
      breedList.clear();
      allBreedsMap.forEach((key, value) {
        breedList.add(Breed(name: key, subBreeds: List<String>.from(value)));
      });
      //breedList = List<Breed>.from(json["message"].map((String breedName,dynamic subBreeds) => Breed(name: breedName,subBreeds: subBreeds)));
      print(response);
    } catch (exc) {
      failLoading.value = true;
    }

    isLoading.value = false;
  }
}

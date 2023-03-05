import 'dart:async';
import 'package:all_in_one_game/model/game_model.dart';
import 'package:all_in_one_game/model/ads_model.dart';
import 'package:all_in_one_game/intro_screen/intro.dart';
import 'package:all_in_one_game/tab_bar/tabBarScreen.dart';
import 'package:all_in_one_game/utils/preferences/preference_manager.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';

AdsModel adsModel = AdsModel();

class AllInOneCnt extends GetxController {
  Dio dio = Dio();

  RxBool noInternet = false.obs;
  RxBool isLoading = false.obs;
  GameModel? gameModel;
  String basicUrl = 'https://drive.google.com/uc?export=view&id=';

  Future getAdsData() async {
    try {
      var response =
          await dio.get('https://sahilisamaliya.github.io/exam/ads.json');
      adsModel = AdsModel.fromJson(response.data);
      print("adsModel?.data ${adsModel.data?.mrecAdId}");
    } catch (e) {
      rethrow;
    }
  }

  Future<GameModel?> getGameData() async {
    try {
      isLoading.value = true;
      noInternet.value = false;
      var response = await dio
          .get('https://sahilisamaliya.github.io/exam/allInOneGame.json');

      // List<dynamic> musicList = response.data['data'];
      gameModel = GameModel.fromJson(response.data);
      await getAdsData();
      print(gameModel?.slider?.first.gameimage);

      if (response.statusCode == 200) {
        if (AppPreference().getBool("welcome")) {
          Get.off(() => const TabBarPage(), transition: Transition.rightToLeft);
        } else {
          Get.off(() => const IntroScreen(),
              transition: Transition.rightToLeft);
        }
      }
      isLoading.value = false;
    } catch (e) {
      print("error $e");
      isLoading.value = false;
      noInternet.value = true;
    }
    isLoading.value = false;
    return gameModel;
  }

  Future<GameModel?> getCategory() async {
    try {
      isLoading.value = true;
      noInternet.value = false;
      var response = await dio
          .get('https://sahilisamaliya.github.io/exam/allInOneGame.json');

      // List<dynamic> musicList = response.data['data'];
      gameModel = GameModel.fromJson(response.data);
      isLoading.value = false;
    } catch (e) {
      isLoading.value = false;
      noInternet.value = true;
    }
    isLoading.value = false;
    return gameModel;
  }
}

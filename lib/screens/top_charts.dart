import 'package:all_in_one_game/ad_manager.dart';
import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/game_model.dart';
import 'package:all_in_one_game/screens/selected_game_screen.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TopChartScreen extends StatefulWidget {
  const TopChartScreen({super.key});

  @override
  State<TopChartScreen> createState() => _TopChartScreenState();
}

class _TopChartScreenState extends State<TopChartScreen> {
  final controller = Get.put(AllInOneCnt());
  final ads = Get.put(AdManager());
  List<Topcharting>? data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    data?.clear();
    init();
  }

  init() async {
    try {
      await controller.getGameData();
      data = controller.gameModel?.topcharting;
      for (int i = 0; i < data!.length; i++) {
        if (i % 3 == 0) {
          data?.insert(
              i,
              Topcharting(
                  id: "",
                  gamedes: "",
                  gameimage: "",
                  gamename: "",
                  gameurl: "",
                  isNativeAd: true));
        }
      }
      data?.removeAt(0);
    } catch (e) {
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(color: ColorUtils.buttonColor))
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Center(
                child: Wrap(
                  spacing: 20,
                  alignment: WrapAlignment.center,
                  children: data!.map((e) {
                    return e.isNativeAd == true
                        ? ads.showMrec
                        : Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                InkWell(
                                    onTap: () => Get.to(
                                        () => SelectedGameScreen(game: e),
                                        transition: Transition.rightToLeft),
                                    child: Container(
                                      height: 170,
                                      width: MediaQuery.of(context).size.width /
                                              2 -
                                          30,
                                      decoration: const BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15))),
                                      child: ClipRRect(
                                          borderRadius: const BorderRadius.all(
                                              Radius.circular(15)),
                                          child: CachedNetworkImage(
                                              imageUrl: "${e.gameimage}",
                                              fit: BoxFit.cover)),
                                    )),
                                const SizedBox(height: 10),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width / 2 -
                                      30,
                                  child: CustomText(
                                    text: "${e.gamename}",
                                    size: 18,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                )
                              ],
                            ),
                          );
                  }).toList(),
                ),
              ),
            ),
    ));
  }
}

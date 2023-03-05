import 'package:all_in_one_game/ad_manager/ad_manager.dart';
import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/model/game_model.dart';
import 'package:all_in_one_game/internet_connection/connection_manager_controller.dart';
import 'package:all_in_one_game/internet_connection/no_internet_screen.dart';
import 'package:all_in_one_game/screens/selected_game_screen.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryListScreen extends StatefulWidget {
  const CategoryListScreen({
    super.key,
    required this.category,
    required this.index,
  });
  final Category? category;
  final int index;
  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {
  final cnt = Get.put(ConnectionManagerController());
  final ads = Get.put(AdManager());
  final allInOneCnt = Get.put(AllInOneCnt());
  List<GameList>? gameList = <GameList>[];
  GameModel? gameModel;

  @override
  void initState() {
    super.initState();
    init();
  }

  init() async {
    try {
      gameList?.clear();
      gameModel = await allInOneCnt.getCategory();
      gameList = gameModel?.category?[widget.index].gameList;
      gameList?.shuffle();
      for (int i = 0; i < gameList!.length; i++) {
        if (i % adsModel.data!.categoryChartLength! == 0) {
          gameList?.insert(
              i,
              GameList(
                  id: "",
                  gamedes: "",
                  gameimage: "",
                  gamename: "",
                  gameurl: "",
                  isNativeAd: true));
        }
      }
      gameList?.removeAt(0);
    } catch (e) {
      print("error-error $e");
      // TODO
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: ads.banner,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtils.primaryColor,
        title: Text("${widget.category?.name}"),
      ),
      body: Obx(
        () => allInOneCnt.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(color: ColorUtils.buttonColor))
            : cnt.connectionType.value
                ? const NoInternetScreen()
                : SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Center(
                      child: Wrap(
                        spacing: 20,
                        alignment: WrapAlignment.center,
                        children: gameList!.map((e) {
                          return e.isNativeAd == true
                              ? ads.showMrec
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      InkWell(
                                          onTap: () => Get.to(
                                              () => SelectedGameScreen(game: e),
                                              transition:
                                                  Transition.rightToLeft),
                                          child: Container(
                                            height: 170,
                                            width: MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    2 -
                                                30,
                                            decoration: const BoxDecoration(
                                                color: Colors.transparent,
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(15))),
                                            child: ClipRRect(
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(15)),
                                                child: CachedNetworkImage(
                                                    imageUrl: "${e.gameimage}",
                                                    fit: BoxFit.cover)),
                                          )),
                                      const SizedBox(height: 10),
                                      SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                    2 -
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
      ),
    );
  }
}

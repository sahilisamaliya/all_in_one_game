import 'package:all_in_one_game/ad_manager/ad_manager.dart';
import 'package:all_in_one_game/internet_connection/connection_manager_controller.dart';
import 'package:all_in_one_game/internet_connection/no_internet_screen.dart';
import 'package:all_in_one_game/screens/game_play.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedGameScreen extends StatefulWidget {
  SelectedGameScreen({super.key, required this.game});

  var game;

  @override
  State<SelectedGameScreen> createState() => _SelectedGameScreenState();
}

class _SelectedGameScreenState extends State<SelectedGameScreen> {
  final cnt = Get.put(ConnectionManagerController());
  final ads = Get.put(AdManager());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    ads.showInterAd();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => cnt.connectionType.value
          ? const NoInternetScreen()
          : Scaffold(
              bottomNavigationBar: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                child: GestureDetector(
                  onTap: () {
                    ads.showInterAd();
                    Get.to(() => GamePlayScreen(gameUrl: widget.game.gameurl));
                  },
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                        color: ColorUtils.buttonColor,
                        borderRadius: BorderRadius.circular(99)),
                    child: const Center(
                        child: CustomText(
                            text: 'PLAY NOW',
                            fontWeight: FontWeight.w400,
                            size: 14)),
                  ),
                ),
              ),
              appBar: AppBar(
                elevation: 0,
                backgroundColor: ColorUtils.primaryColor,
                title: Text('${widget.game.gamename}'),
              ),
              body: Center(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: 25),
                      Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            image: DecorationImage(
                                image: CachedNetworkImageProvider(
                                    '${widget.game.gameimage}'),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: "${widget.game.gamename}",
                        fontWeight: FontWeight.bold,
                        size: 25,
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: "${widget.game.gamedes}",
                        size: 17,
                        color: ColorUtils.lightTextColor,
                        textAlign: TextAlign.center,
                      ),
                      ads.showMrec
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

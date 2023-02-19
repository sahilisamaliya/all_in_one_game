import 'package:all_in_one_game/game_model.dart';
import 'package:all_in_one_game/internet_connection/connection_manager_controller.dart';
import 'package:all_in_one_game/internet_connection/no_internet_screen.dart';
import 'package:all_in_one_game/screens/game_play.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SelectedGameScreen extends StatefulWidget {
  const SelectedGameScreen(
      {super.key, required this.game, required this.index});

  final List? game;
  final int index;
  @override
  State<SelectedGameScreen> createState() => _SelectedGameScreenState();
}

class _SelectedGameScreenState extends State<SelectedGameScreen> {
  final cnt = Get.put(ConnectionManagerController());

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
                    Get.to(() => GamePlayScreen(
                        gameUrl: widget.game?[widget.index].gameurl));
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
                title: Text('${widget.game?[widget.index].gamename}'),
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
                                    '${widget.game?[widget.index].gameimage}'),
                                fit: BoxFit.cover)),
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: "${widget.game?[widget.index].gamename}",
                        fontWeight: FontWeight.bold,
                        size: 25,
                      ),
                      const SizedBox(height: 20),
                      CustomText(
                        text: "${widget.game?[widget.index].gamedes}",
                        size: 17,
                        color: ColorUtils.lightTextColor,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}

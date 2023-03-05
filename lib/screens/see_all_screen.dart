import 'package:all_in_one_game/ad_manager/ad_manager.dart';
import 'package:all_in_one_game/internet_connection/connection_manager_controller.dart';
import 'package:all_in_one_game/internet_connection/no_internet_screen.dart';
import 'package:all_in_one_game/screens/selected_game_screen.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class SeeAllScreen extends StatefulWidget {
  const SeeAllScreen({super.key, this.allGame, required this.title});

  final List? allGame;
  final String title;
  @override
  State<SeeAllScreen> createState() => _SeeAllScreenState();
}

class _SeeAllScreenState extends State<SeeAllScreen> {
  final cnt = Get.put(ConnectionManagerController());
  final ads = Get.put(AdManager());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       bottomNavigationBar: ads.banner,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtils.primaryColor,
        title: Text(widget.title),
      ),
      body: Obx(
        () => cnt.connectionType.value
            ? const NoInternetScreen()
            : SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Center(
                  child: Wrap(
                    spacing: 20,
                    alignment: WrapAlignment.center,
                    children: widget.allGame!.map((e) {
                      return  Padding(
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
                                        width:
                                            MediaQuery.of(context).size.width /
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
                                        MediaQuery.of(context).size.width / 2 -
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

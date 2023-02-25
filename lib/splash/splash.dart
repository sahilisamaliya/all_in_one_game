import 'package:all_in_one_game/ad_manager.dart';
import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/internet_connection/no_internet_screen.dart';
import 'package:all_in_one_game/tab_bar/tabBarScreen.dart';
import 'package:all_in_one_game/intro_screen/intro.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:all_in_one_game/utils/preferences/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final ads = Get.put(AdManager());
  final controller = Get.put(AllInOneCnt());

  @override
  void initState() {
    // TODO: implement initState
    init();
    super.initState();
  }

  Future<void> init() async {
    await controller.getGameData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xff181A20),
        body: Obx(
          () => controller.noInternet.value
              ? const NoInternetScreen()
              : Center(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 150,
                            width: 150,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(7),
                                image: const DecorationImage(
                                    image: AssetImage(
                                        'assets/images/playstore.png'))),
                          ),
                          const SizedBox(height: 20),
                          const Center(
                            child: CustomText(
                              text: "All In One Game 2023",
                              size: 17,
                            ),
                          ),
                        ],
                      ),
                      const Positioned(
                        bottom: 50,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
        ));
  }
}

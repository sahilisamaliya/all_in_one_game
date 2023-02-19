import 'package:all_in_one_game/tab_bar/tabBarScreen.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:all_in_one_game/utils/preferences/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IntroScreen extends StatelessWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/intro.jpg'),
                fit: BoxFit.cover)),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const CustomText(
                  text: "Welcome To All In One Game",
                  size: 35,
                  textAlign: TextAlign.center,
                  fontWeight: FontWeight.w500),
              Center(
                child: InkWell(
                  onTap: () async {
                    await AppPreference().setBool("welcome", true);
                    Get.offAll(() => const TabBarPage(),
                        transition: Transition.rightToLeft);
                  },
                  child: Container(
                    height: 45,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 40),
                    decoration: BoxDecoration(
                        color: ColorUtils.buttonColor,
                        borderRadius: BorderRadius.circular(99)),
                    child: const Center(
                        child: CustomText(
                            text: 'GET STARTED',
                            fontWeight: FontWeight.w400,
                            size: 14)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cnt = Get.put(AllInOneCnt());
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CustomText(
                text: 'No Internet',
                textAlign: TextAlign.start,
                fontWeight: FontWeight.w400,
                size: 20,
                color: ColorUtils.white),
            const SizedBox(height: 50),
            GestureDetector(
              onTap: () async {
                await cnt.getGameData();
              },
              child: Container(
                height: 45,
                width: 200,
                decoration: BoxDecoration(
                    color: ColorUtils.white,
                    borderRadius: BorderRadius.circular(99)),
                child: Center(
                    child: CustomText(
                        text: 'Retry',
                        fontWeight: FontWeight.w400,
                        size: 14,
                        color: ColorUtils.blackColor)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

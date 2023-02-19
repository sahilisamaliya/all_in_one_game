import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/screens/category_list.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final controller = Get.put(AllInOneCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: ListView.separated(
            physics: const BouncingScrollPhysics(),
            itemBuilder: (context, index) {
              return ListTile(
                title: CustomText(
                    text: "${controller.gameModel?.category?[index].name}"),
                onTap: () => Get.to(
                    () => CategoryListScreen(
                          category: controller.gameModel?.category?[index],
                        ),
                    transition: Transition.rightToLeft),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider(color: ColorUtils.dividerColor);
            },
            itemCount: controller.gameModel!.category!.length),
      ),
    );
  }
}
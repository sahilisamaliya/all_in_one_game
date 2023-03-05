import 'package:all_in_one_game/ad_manager/ad_manager.dart';
import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/internet_connection/connection_manager_controller.dart';
import 'package:all_in_one_game/internet_connection/no_internet_screen.dart';
import 'package:all_in_one_game/screens/game_play.dart';
import 'package:all_in_one_game/screens/see_all_screen.dart';
import 'package:all_in_one_game/screens/selected_game_screen.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForYouScreen extends StatefulWidget {
  const ForYouScreen({super.key});

  @override
  State<ForYouScreen> createState() => _ForYouScreenState();
}

class _ForYouScreenState extends State<ForYouScreen> {
  final controller = Get.put(AllInOneCnt());
  final cnt = Get.put(ConnectionManagerController());
  final ads = Get.put(AdManager());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.gameModel?.slider?.shuffle();
    controller.gameModel?.suggested?.shuffle();
    controller.gameModel?.newgame?.shuffle();
    controller.gameModel?.toprating?.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => cnt.connectionType.value
            ? const NoInternetScreen()
            : ListView(
                shrinkWrap: true,
                physics: const BouncingScrollPhysics(),
                children: [
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 230,
                      // aspectRatio: 16 / 9,
                      // viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      // autoPlayInterval: const Duration(seconds: 3),
                      // autoPlayAnimationDuration: const Duration(milliseconds: 1000),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      // enlargeFactor: 0.3,
                      scrollDirection: Axis.horizontal,
                    ),
                    items: controller.gameModel?.slider?.map((i) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                              width: MediaQuery.of(context).size.width,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 5.0, vertical: 30),
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: CachedNetworkImageProvider(
                                          '${i.gameimage}')),
                                  borderRadius: BorderRadius.circular(25)),
                              child: InkWell(
                                onTap: () => Get.to(
                                    () => SelectedGameScreen(game: i),
                                    transition: Transition.rightToLeft),
                                child: Stack(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(25),
                                        gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              ColorUtils.blackColor
                                                  .withOpacity(0.8),
                                              Colors.transparent
                                            ],
                                            stops: const [
                                              0.0,
                                              0.40
                                            ]),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          left: 20, bottom: 20),
                                      child: Align(
                                        alignment: Alignment.bottomLeft,
                                        child: CustomText(
                                          text: "${i.gamename}",
                                          textAlign: TextAlign.start,
                                          size: 20,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ));
                        },
                      );
                    }).toList(),
                  ),
                  ads.banner,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(text: 'Suggested for You', size: 18),
                        InkWell(
                          onTap: () {
                            Get.to(
                                () => SeeAllScreen(
                                      allGame: controller.gameModel?.suggested,
                                      title: "Suggested for You",
                                    ),
                                transition: Transition.rightToLeft);
                          },
                          child: const CustomText(
                            text: 'See All',
                            size: 15,
                            color: ColorUtils.buttonColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.gameModel?.suggested?.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CommonWidget(
                          image:
                              "${controller.gameModel?.suggested?[index].gameimage}",
                          text:
                              "${controller.gameModel?.suggested?[index].gamename}",
                          onTap: () => Get.to(
                              () => SelectedGameScreen(
                                    game:
                                        controller.gameModel?.suggested?[index],
                                  ),
                              transition: Transition.rightToLeft),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(text: 'New Games', size: 18),
                        InkWell(
                          onTap: () {
                            Get.to(
                                () => SeeAllScreen(
                                      allGame: controller.gameModel?.newgame,
                                      title: "New Games",
                                    ),
                                transition: Transition.rightToLeft);
                          },
                          child: const CustomText(
                            text: 'See All',
                            size: 15,
                            color: ColorUtils.buttonColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.gameModel?.newgame?.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CommonWidget(
                          image:
                              "${controller.gameModel?.newgame?[index].gameimage}",
                          text:
                              "${controller.gameModel?.newgame?[index].gamename}",
                          onTap: () => Get.to(
                              () => SelectedGameScreen(
                                    game: controller.gameModel?.newgame?[index],
                                  ),
                              transition: Transition.rightToLeft),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const CustomText(text: 'Top Rated Games', size: 18),
                        InkWell(
                          onTap: () {
                            Get.to(
                                () => SeeAllScreen(
                                      allGame: controller.gameModel?.toprating,
                                      title: "Top Rated Games",
                                    ),
                                transition: Transition.rightToLeft);
                          },
                          child: const CustomText(
                            text: 'See All',
                            size: 15,
                            color: ColorUtils.buttonColor,
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 160,
                    child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.gameModel?.toprating?.length,
                      physics: const BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return CommonWidget(
                          image:
                              "${controller.gameModel?.toprating?[index].gameimage}",
                          text:
                              "${controller.gameModel?.toprating?[index].gamename}",
                          onTap: () => Get.to(
                              () => SelectedGameScreen(
                                    game:
                                        controller.gameModel?.toprating?[index],
                                  ),
                              transition: Transition.rightToLeft),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}

class CommonWidget extends StatelessWidget {
  const CommonWidget(
      {super.key, required this.text, required this.image, this.onTap});

  final String text;
  final String image;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: onTap,
            child: Container(
              height: 130,
              width: 130,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(image)),
              ),
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 130,
            child: CustomText(
              text: text,
              size: 15,
              textAlign: TextAlign.start,
              fontWeight: FontWeight.w300,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}

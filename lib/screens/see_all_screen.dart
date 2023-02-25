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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: ColorUtils.primaryColor,
        title: Text(widget.title),
      ),
      body: Obx(
        () => cnt.connectionType.value
            ? const NoInternetScreen()
            : Padding(
                padding: const EdgeInsets.only(left: 15, right: 15, bottom: 15),
                child: GridView.builder(
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 5 / 4.7,
                            crossAxisSpacing: 15,
                            mainAxisSpacing: 15),
                    itemCount: widget.allGame?.length,
                    itemBuilder: (BuildContext ctx, index) {
                      return GestureDetector(
                        onTap: () => Get.to(()=> SelectedGameScreen(game: widget.allGame?[index])),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 130,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(15),
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                          '${widget.allGame?[index].gameimage}'),
                                      fit: BoxFit.cover)),
                            ),
                            const SizedBox(height: 5),
                            Flexible(
                              child: CustomText(
                                  text: '${widget.allGame?[index].gamename}',
                                  fontWeight: FontWeight.w600,
                                  size: 17,
                                  overflow: TextOverflow.ellipsis,
                                  color: ColorUtils.white),
                            ),
                          ],
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}

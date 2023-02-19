import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/screens/selected_game_screen.dart';
import 'package:all_in_one_game/utils/custom_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

class TopChartScreen extends StatefulWidget {
  const TopChartScreen({super.key});

  @override
  State<TopChartScreen> createState() => _TopChartScreenState();
}

class _TopChartScreenState extends State<TopChartScreen> {
  final controller = Get.put(AllInOneCnt());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(15),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        mainAxisSpacing: 15,
        crossAxisSpacing: 15,
        shrinkWrap: true,
        physics: const BouncingScrollPhysics(),
        itemCount: controller.gameModel?.topcharting?.length,
        itemBuilder: (context, index) {
          return Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    onTap: () => Get.to(() => SelectedGameScreen(
                          game: controller.gameModel?.topcharting,
                          index: index,
                        )),
                    child: Container(
                      width: 200,
                      decoration: const BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.all(Radius.circular(15))),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(15)),
                          child: CachedNetworkImage(
                              imageUrl:
                                  "${controller.gameModel?.topcharting?[index].gameimage}",
                              fit: BoxFit.cover)),
                    )),
                const SizedBox(height: 10),
                CustomText(
                  text: "${controller.gameModel?.topcharting?[index].gamename}",
                  size: 18,
                )
              ],
            ),
          );
        },
      ),
    ));
  }
}

List<String> imageList = [
  'https://agamecdn.com/system/static/thumbs/spil_thumb_big/27922/webp_1609756524_Fireboy-and-Watergirl-The-Forest-Temple-200x120.webp?1633620353',
  'https://agamecdn.com/system/static/thumbs/spil_thumb_big/73490/webp_Find-the-Difference-200x120.webp?1676555542',
  'https://agamecdn.com/system/static/thumbs/spil_thumb_big/73478/webp_Zen-Sort-Parking-Puzzle-200x120.webp?1676462629',
  'https://img.poki.com/cdn-cgi/image/quality=78,width=94,height=94,fit=cover,f=auto/5cc06f22e46c13e1c7917dad7c48e5dd.png',
  'https://cdn.pixabay.com/photo/2019/11/05/00/53/cellular-4602489_960_720.jpg',
  'https://data.gameflare.com/games/9781/tQnXJ0sxJJBIzJ-400-300.jpg',
  'https://img.poki.com/cdn-cgi/image/quality=78,width=94,height=94,fit=cover,f=auto/7eb8c4c7bba7373b84741b54eb756856.png',
  'https://cdn.pixabay.com/photo/2020/02/06/20/01/university-library-4825366_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/11/22/17/28/cat-5767334_960_720.jpg',
  'https://cdn.pixabay.com/photo/2020/12/13/16/22/snow-5828736_960_720.jpg',
  'https://img.poki.com/cdn-cgi/image/quality=78,width=94,height=94,fit=cover,f=auto/d710fe8830d731072485a582881605ea.png',
];

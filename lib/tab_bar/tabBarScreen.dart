import 'package:all_in_one_game/ad_manager/ad_manager.dart';
import 'package:all_in_one_game/screens/category.dart';
import 'package:all_in_one_game/screens/for_you_screen.dart';
import 'package:all_in_one_game/screens/top_charts.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TabBarPage extends StatefulWidget {
  const TabBarPage({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<TabBarPage> with TickerProviderStateMixin {
  TabController? _controller;
  final ads = Get.put(AdManager());

  final List<Tab> topTabs = <Tab>[
    const Tab(text: 'For You'),
    const Tab(text: 'Top Charts'),
    const Tab(text: 'Category'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = TabController(vsync: this, length: 3);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        bottomNavigationBar: ads.banner,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: ColorUtils.primaryColor,
          title: const Text('All In One Game'),
          bottom: TabBar(
              tabs: topTabs,
              unselectedLabelColor: ColorUtils.grey,
              dividerColor: ColorUtils.buttonColor,
              indicatorColor: ColorUtils.buttonColor,
              labelColor: ColorUtils.buttonColor,
              automaticIndicatorColorAdjustment: true),
        ),
        body: const TabBarView(
          children: [ForYouScreen(), TopChartScreen(), CategoryScreen()],
        ),
      ),
    );
  }
}

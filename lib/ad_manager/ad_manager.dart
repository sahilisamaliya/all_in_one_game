import 'dart:math';
import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:all_in_one_game/utils/preferences/preference_manager.dart';
import 'package:applovin_max/applovin_max.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int addLimit = 0;

class AdManager extends GetxController with WidgetsBindingObserver {
  var interstitialRetryAttempt = 0;
  bool isInterstitialVideoAvailable = false;
  @override
  void onInit() {
    super.onInit();

    AppLovinMAX.setAppOpenAdListener(AppOpenAdListener(
      onAdLoadedCallback: (ad) {
        print('Open add loaded');
      },
      onAdLoadFailedCallback: (adUnitId, error) {},
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {
        AppLovinMAX.loadAppOpenAd(openAdId);
      },
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        AppLovinMAX.loadAppOpenAd(openAdId);
      },
      onAdRevenuePaidCallback: (ad) {},
    ));

    AppLovinMAX.loadAppOpenAd(openAdId);
    loadInterAd();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        await showAdIfReady();
        break;

      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
      case AppLifecycleState.detached:
        break;
    }
  }

  Future<void> showAdIfReady() async {
    if (!AppPreference().getBool("sdk")) {
      return;
    }
    bool isReady = (await AppLovinMAX.isAppOpenAdReady(openAdId))!;
    if (isReady) {
      AppLovinMAX.showAppOpenAd(openAdId);
    } else {
      AppLovinMAX.loadAppOpenAd(openAdId);
    }
  }

  // showMrecAd() {
  Widget showMrec = Center(
    child: MaxAdView(
      adUnitId: "${adsModel.data?.mrecAdId}",
      adFormat: AdFormat.mrec,
      listener: AdViewAdListener(
        onAdLoadedCallback: (ad) {},
        onAdLoadFailedCallback: (adUnitId, error) {},
        onAdClickedCallback: (ad) {},
        onAdExpandedCallback: (ad) {},
        onAdCollapsedCallback: (ad) {},
      ),
    ),
  );
  // }
  Widget banner = MaxAdView(
      adUnitId: "${adsModel.data?.bannerAdId}",
      adFormat: AdFormat.banner,
      listener: AdViewAdListener(
          onAdLoadedCallback: (ad) {},
          onAdLoadFailedCallback: (adUnitId, error) {},
          onAdClickedCallback: (ad) {},
          onAdExpandedCallback: (ad) {},
          onAdCollapsedCallback: (ad) {}));

  void loadInterAd() {
    AppLovinMAX.setInterstitialListener(InterstitialListener(
      onAdLoadedCallback: (ad) {
        interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        interstitialRetryAttempt = interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, interstitialRetryAttempt)).toInt();

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {});
        AppLovinMAX.loadInterstitial(adUnitId);
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {},
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {
        loadInterAd();
      },
    ));

    AppLovinMAX.loadInterstitial(interAdId);
  }

  void showInterAd() async {
    // if (flag!) {
    String index = AppPreference().getString("addLimit");

    print("index-index $index");
    if (index == adsModel.data?.adsClickLimit) {
      isInterstitialVideoAvailable =
          (await AppLovinMAX.isInterstitialReady(interAdId))!;

      if (isInterstitialVideoAvailable) {
        AppLovinMAX.showInterstitial(interAdId);
      } else {
        AppLovinMAX.loadInterstitial(interAdId);
        Future.delayed(
          const Duration(seconds: 2),
          () => AppLovinMAX.showInterstitial(interAdId),
        );
      }

      AppPreference().setString("addLimit", "1");
    } else {
      int i = int.parse(index);
      i++;
      AppPreference().setString("addLimit", i.toString());
    }
  }
}

String openAdId = "${adsModel.data?.openAdId}";
String interAdId = "${adsModel.data?.interAdId}";

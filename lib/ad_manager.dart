import 'dart:math';
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

    print("AppPreference().getBool ${AppPreference().getBool("sdk")}");
    // if (AppPreference().getBool("sdk")) {
      print("open ads called");
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
    // }
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
      adUnitId: "906e1e4a319a2008",
      adFormat: AdFormat.mrec,
      listener: AdViewAdListener(
        onAdLoadedCallback: (ad) {
          print("Failed add$ad");
        },
        onAdLoadFailedCallback: (adUnitId, error) {
          print("Failed add$error");
          print("Error aavi 6 $error");
        },
        onAdClickedCallback: (ad) {},
        onAdExpandedCallback: (ad) {},
        onAdCollapsedCallback: (ad) {},
      ),
    ),
  );
  // }
  Widget banner = MaxAdView(
      adUnitId: "98e2f1bd281dc453",
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
        print('Interstitial ad loaded from ${ad.networkName}');
        interstitialRetryAttempt = 0;
      },
      onAdLoadFailedCallback: (adUnitId, error) {
        interstitialRetryAttempt = interstitialRetryAttempt + 1;

        int retryDelay = pow(2, min(6, interstitialRetryAttempt)).toInt();

        print(
            'Interstitial ad failed to load with code ${error.code} - retrying in ${retryDelay}s');

        Future.delayed(Duration(milliseconds: retryDelay * 1000), () {});
        AppLovinMAX.loadInterstitial(adUnitId);
      },
      onAdDisplayedCallback: (ad) {},
      onAdDisplayFailedCallback: (ad, error) {},
      onAdClickedCallback: (ad) {},
      onAdHiddenCallback: (ad) {},
    ));

    AppLovinMAX.loadInterstitial('e6d975d8a21f7bd5');
  }

  void showInterAd() async {
    // if (flag!) {
    String index = AppPreference().getString("addLimit");

    if (int.parse(index) == 3) {
      isInterstitialVideoAvailable =
          (await AppLovinMAX.isInterstitialReady("e6d975d8a21f7bd5"))!;

      if (isInterstitialVideoAvailable) {
        AppLovinMAX.showInterstitial("e6d975d8a21f7bd5");
      } else {
        AppLovinMAX.loadInterstitial("e6d975d8a21f7bd5");
        Future.delayed(
          const Duration(seconds: 2),
          () => AppLovinMAX.showInterstitial("e6d975d8a21f7bd5"),
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

String openAdId = "bb7efb72e6ad7780";

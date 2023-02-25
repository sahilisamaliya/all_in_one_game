import 'dart:math';
import 'package:applovin_max/applovin_max.dart';
import 'package:board_exam_paper/preference_manager.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

int addLimit = 0;

class AdManager extends GetxController with WidgetsBindingObserver {
  var interstitialRetryAttempt = 0;
  bool isInterstitialVideoAvailable = false;

  @override
  void onInit() {
    super.onInit();

    if (AppPreference().getBool("sdk")) {
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
    }

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

  // String? adUnitId;

  // //
  // AdManager({
  //   this.adUnitId,
  // });

  //
  // @override
  // void onInit() {
  //   FlutterApplovinMax.initRewardAd("6a7db616415020ae");
  //   FlutterApplovinMax.initInterstitialAd('$adUnitId');
  //   super.onInit();
  // }
  //
  //
  // void listener(AppLovinAdListener? event) {
  //   if (event == AppLovinAdListener.onUserRewarded) {
  //     print('👍get reward');
  //   }
  // }
  //
  // Future showRewarded() async {
  //   // isRewardedVideoAvailable =
  //   //     await FlutterApplovinMax.isRewardLoaded(listener);
  //   // if (isRewardedVideoAvailable ?? false) {
  //   //   await FlutterApplovinMax.showRewardVideo(listener);
  //   // }
  // }
  //
  // void showInterAd(bool? flag) async {
  //   if (flag ?? true) {
  //     String index = AppPreference().getString("addLimit");
  //
  //     if (int.parse(index) == addLimit) {
  //       isInterstitialVideoAvailable =
  //           (await FlutterApplovinMax.isInterstitialLoaded(listener))!;
  //       if (isInterstitialVideoAvailable) {
  //         FlutterApplovinMax.showInterstitialVideo(
  //             (AppLovinAdListener? event) => listener(event));
  //       }
  //
  //       AppPreference().setString("addLimit", "1");
  //     } else {
  //       int i = int.parse(index);
  //       i++;
  //       AppPreference().setString("addLimit", i.toString());
  //     }
  //   }
  // }

  showMrecAd() {
    return MaxAdView(
      adUnitId: "dd0099f3f8ede4b2",
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
    );
    // return MaxAdView(
    //     adUnitId: "dd0099f3f8ede4b2",
    //     adFormat: AdFormat.mrec,
    //     listener: AdViewAdListener(
    //         onAdLoadedCallback: (ad) {},
    //         onAdLoadFailedCallback: (adUnitId, error) {},
    //         onAdClickedCallback: (ad) {},
    //         onAdExpandedCallback: (ad) {},
    //         onAdCollapsedCallback: (ad) {}));
  }

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

    AppLovinMAX.loadInterstitial('e6f7f8dcc9d18078');
  }

  void showInterAd() async {
    // if (flag!) {
    String index = AppPreference().getString("addLimit");

    if (int.parse(index) == 3) {
      isInterstitialVideoAvailable =
          (await AppLovinMAX.isInterstitialReady("e6f7f8dcc9d18078"))!;

      if (isInterstitialVideoAvailable) {
        AppLovinMAX.showInterstitial("e6f7f8dcc9d18078");
      } else {
        AppLovinMAX.loadInterstitial("e6f7f8dcc9d18078");
        Future.delayed(
          const Duration(seconds: 2),
          () => AppLovinMAX.showInterstitial("e6f7f8dcc9d18078"),
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

// }

String openAdId = "9d5b7665e5c4b797";

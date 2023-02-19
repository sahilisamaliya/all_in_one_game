import 'dart:async';

import 'package:all_in_one_game/controller/all_in_one_cnt.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ConnectionManagerController extends GetxController {
  //0 = No Internet, 1 = WIFI Connected ,2 = Mobile Data Connected.
  RxBool connectionType = false.obs;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription _streamSubscription;
  final cnt = Get.put(AllInOneCnt());
  @override
  void onInit() {
    super.onInit();
    getConnectivityType();
    _streamSubscription = _connectivity.onConnectivityChanged.listen(_updateState);
  }

  Future<void> getConnectivityType() async {
    late ConnectivityResult connectivityResult;
    try {
      connectivityResult = await (_connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return _updateState(connectivityResult);
  }

  _updateState(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.wifi:
        connectionType.value = false;
        cnt.noInternet.value = false;
        break;
      case ConnectivityResult.mobile:
        connectionType.value = false;
        cnt.noInternet.value = false;
        break;
      case ConnectivityResult.none:
        connectionType.value = true;
        break;
      default:
        break;
    }
  }

  @override
  void onClose() {
    _streamSubscription.cancel();
  }
}

class ControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ConnectionManagerController>(
            () => ConnectionManagerController());
  }
}
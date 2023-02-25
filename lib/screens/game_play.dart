// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:all_in_one_game/internet_connection/connection_manager_controller.dart';
import 'package:all_in_one_game/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

class GamePlayScreen extends StatefulWidget {
  const GamePlayScreen({super.key, required this.gameUrl});

  final String gameUrl;
  @override
  State<GamePlayScreen> createState() => _GamePlayScreenState();
}

class _GamePlayScreenState extends State<GamePlayScreen> {
  late final WebViewController controller;
  bool isLoading = true;
  final cnt = Get.put(ConnectionManagerController());
  @override
  void initState() {
    super.initState();

    // #docregion webview_controller
    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(ColorUtils.primaryColor)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {
            // Update loading bar.
          },
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print("error $error");
            Get.back();
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.gameUrl));
    // #enddocregion webview_controller
  }

  // #docregion webview_widget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:  isLoading
                ? const Center(child: CircularProgressIndicator(color: ColorUtils.buttonColor))
                : WebViewWidget(controller: controller),
    
    );
  }
  // #enddocregion webview_widget
}

//
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

class WebViewLogger extends StatefulWidget {
  const WebViewLogger({super.key});

  @override
  State<WebViewLogger> createState() => _WebViewLoggerState();
}

class _WebViewLoggerState extends State<WebViewLogger> {
  List urlList = [];
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();

    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller = WebViewController
        .fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onHttpAuthRequest: (HttpAuthRequest request) {
            request.onProceed(
              const WebViewCredential(
                user: "get",
                password: "getracing2005",
              ),
            );
          },
        ),
      )
      // ..addJavaScriptChannel(
      //   'Toaster',
      //   onMessageReceived: (JavaScriptMessage message) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(content: Text(message.message)),
      //     );
      //   },
      // )
      ..loadRequest(Uri.parse(
          'https://datalogger.get-racing.de/d/bdu7eam3cq7eod/driverless-webapp?orgId=1&refresh=1h&from=now-30d&to=now&kiosk'));

    // #docregion platform_features
    // if (controller.platform is AndroidWebViewController) {
    //   AndroidWebViewController.enableDebugging(true);
    //   (controller.platform as AndroidWebViewController)
    //       .setMediaPlaybackRequiresUserGesture(false);
    // }
    // #enddocregion platform_features

    _controller = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('DataLogger'),
          actions: [
            IconButton(
                onPressed: () {
                  _promptForUrl(context);
                },
                icon: const Icon(Icons.add))
          ],
        ),
        body: WebViewWidget(controller: _controller));
  }

  Future<void> _promptForUrl(BuildContext context) {
    final TextEditingController urlTextController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog.adaptive(
          title: const Text('Input URL to Visualize'),
          content: TextField(
            decoration: const InputDecoration(labelText: 'URL'),
            autofocus: true,
            controller: urlTextController,
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {},
              child: const Text('Add'),
            ),
          ],
        );
      },
    );
  }
}

//
// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:racetracer/src/application/embed/embed_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
// #docregion platform_imports
// Import for Android features.
import 'package:webview_flutter_android/webview_flutter_android.dart';
// Import for iOS features.
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
// #enddocregion platform_imports

void main() => runApp(const MaterialApp(home: EmbedPage()));

class EmbedPage extends StatefulWidget {
  const EmbedPage({super.key});

  @override
  State<EmbedPage> createState() => _EmbedPageState();
}

class _EmbedPageState extends State<EmbedPage> {
  // late final WebViewController _controller;

  // @override
  // void initState() {
  //   super.initState();

  // #docregion platform_features
  // late final PlatformWebViewControllerCreationParams params;
  // if (WebViewPlatform.instance is WebKitWebViewPlatform) {
  //   params = WebKitWebViewControllerCreationParams(
  //     allowsInlineMediaPlayback: true,
  //     mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
  //   );
  // } else {
  //   params = const PlatformWebViewControllerCreationParams();
  // }

  //   final WebViewController controller =
  //       WebViewController.fromPlatformCreationParams(params);

  //   // #enddocregion platform_features

  //   controller
  //     ..setJavaScriptMode(JavaScriptMode.unrestricted)
  //     ..setNavigationDelegate(
  //       NavigationDelegate(
  //         onHttpAuthRequest: (HttpAuthRequest request) {
  //           request.onProceed(
  //             const WebViewCredential(
  //               user: "get",
  //               password: "getracing2005",
  //             ),
  //           );
  //         },
  //       ),
  //     )
  // ..addJavaScriptChannel(
  //   'Toaster',
  //   onMessageReceived: (JavaScriptMessage message) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text(message.message)),
  //     );
  //   },
  // )
  //     ..loadRequest(Uri.parse(
  //         'https://datalogger.get-racing.de/d/bdu7eam3cq7eod/driverless-webapp?orgId=1&refresh=1h&from=now-30d&to=now&kiosk'));

  //   // #docregion platform_features
  //   if (controller.platform is AndroidWebViewController) {
  //     AndroidWebViewController.enableDebugging(true);
  //     (controller.platform as AndroidWebViewController)
  //         .setMediaPlaybackRequiresUserGesture(false);
  //   }
  //   // #enddocregion platform_features

  //   _controller = controller;
  // }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EmbedBloc(),
      child: BlocBuilder<EmbedBloc, EmbedState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('DataLogger'),
              actions: [
                IconButton(
                    onPressed: () {
                      _promptForUrl(
                          context, BlocProvider.of<EmbedBloc>(context));
                    },
                    icon: const Icon(Icons.add))
              ],
            ),
            body: state is! UpdatedState
                ? const Center(
                    child: Text('Add a new widget using + button.'),
                  )
                : Expanded(
                    child: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: state.controllerList.length,
                      itemBuilder: (context, index) => SizedBox(
                        height: MediaQuery.of(context).size.height - 120,
                        child: WebViewWidget(
                            controller: state.controllerList[index]),
                      ),
                    ),
                  ),
          );
        },
      ),
    );
  }

  Future<void> _promptForUrl(BuildContext context, EmbedBloc bloc) {
    final TextEditingController urlTextController = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: bloc,
          child: AlertDialog.adaptive(
            title: const Text('Input URL to Visualize'),
            content: Material(
              child: TextField(
                decoration: const InputDecoration(labelText: 'URL'),
                autofocus: true,
                controller: urlTextController,
              ),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  if (urlTextController.text.isNotEmpty) {
                    bloc.add(AddLinkEvent(url: urlTextController.text));

                    Navigator.pop(context);
                  }
                },
                child: const Text('Add'),
              ),
            ],
          ),
        );
      },
    );
  }
}

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

import 'package:racetracer/src/application/embed/embed_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
              title: Text(AppLocalizations.of(context)!.datalogger),
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
                ? Center(
                    child:
                        Text(AppLocalizations.of(context)!.loggerDescription),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height - 120,
                    child: WebViewWidget(controller: state.controller),
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
            title: Text(AppLocalizations.of(context)!.urlInput),
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
                child: Text(AppLocalizations.of(context)!.add),
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_storage_data_source.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

part 'embed_event.dart';
part 'embed_state.dart';

class EmbedBloc extends Bloc<EmbedEvent, EmbedState> {
  final LocalStorageDataSource localStorageDataSource =
      LocalStorageDataSource();
  EmbedBloc() : super(EmbedInitial()) {
    on<AddLinkEvent>(_onAddLinkEvent);
    on<FetchSavedLinkEvent>(_onFetchSavedLinkEvent);
  }

  FutureOr<void> _onAddLinkEvent(AddLinkEvent event, Emitter<EmbedState> emit) {
    localStorageDataSource.saveLink(event.url);
    final WebViewController controller = loadEmbed(event.url);
    if (state is UpdatedState) {
      emit(UpdatedState(controller: controller));
    } else {
      emit(UpdatedState(controller: controller));
    }
  }

  FutureOr<void> _onFetchSavedLinkEvent(
      FetchSavedLinkEvent event, Emitter<EmbedState> emit) async {
    final String? url = await localStorageDataSource.getLink();

    if (url != null) {
      final WebViewController controller = loadEmbed(url);
      emit(UpdatedState(controller: controller));
    }
  }

  WebViewController loadEmbed(String url) {
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
        WebViewController.fromPlatformCreationParams(params);

    controller
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
      ..loadRequest(Uri.parse('$url&kiosk'));
    return controller;
  }
}

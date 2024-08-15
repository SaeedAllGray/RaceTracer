import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

part 'embed_event.dart';
part 'embed_state.dart';

class EmbedBloc extends Bloc<EmbedEvent, EmbedState> {
  EmbedBloc() : super(EmbedInitial()) {
    on<AddLinkEvent>(_onAddLinkEvent);
  }

  FutureOr<void> _onAddLinkEvent(AddLinkEvent event, Emitter<EmbedState> emit) {
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
      ..loadRequest(Uri.parse('${event.url}&kiosk'));
    if (state is UpdatedState) {
      (state as UpdatedState).controllerList.add(controller);
      emit(
          UpdatedState(controllerList: (state as UpdatedState).controllerList));
    } else {
      emit(UpdatedState(controllerList: [controller]));
    }
  }
}

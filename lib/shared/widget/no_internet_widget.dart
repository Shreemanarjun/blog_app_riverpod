import 'package:blog_app_riverpod/main.dart';
import 'package:blog_app_riverpod/shared/dio_client/dio_provider.dart';
import 'package:blog_app_riverpod/shared/pods/internet_checker_pod.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:rive/rive.dart';
import 'package:velocity_x/velocity_x.dart';

class InternetCheckerWidget extends ConsumerStatefulWidget {
  final Widget child;
  const InternetCheckerWidget({
    super.key,
    required this.child,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _InternetCheckerWidgetState();
}

class _InternetCheckerWidgetState extends ConsumerState<InternetCheckerWidget> {

  InternetConnectionStatus? lastResult;
  void internetListener(
    InternetConnectionStatus status, {
    required void Function() onNointernetOKPressed,
  }) {
    switch (status) {
      case InternetConnectionStatus.connected:
        talker.debug("Data Reconnected.");
        if (lastResult == InternetConnectionStatus.disconnected) {
          ref.invalidate(dioProvider);
          ScaffoldMessenger.of(context)
            ..clearMaterialBanners()
            ..showMaterialBanner(
              MaterialBanner(
                content: const Text(
                  "Got Internet ......Refreshed",
                  style: TextStyle(color: Colors.green),
                ),
                actions: [
                  ElevatedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).clearMaterialBanners();
                      },
                      child: const Text("OK"))
                ],
              ),
            );
          Future.delayed(const Duration(seconds: 2), () {
            ScaffoldMessenger.of(context).clearMaterialBanners();
          });
        } else {
          talker.debug("First Time");
        }
        break;
      case InternetConnectionStatus.disconnected:
        talker.debug("You are disconnected from the internet.");
        ScaffoldMessenger.of(context)
          ..clearMaterialBanners()
          ..showMaterialBanner(
            MaterialBanner(
              content: const Text(
                "No Internet Connection Available",
                style: TextStyle(color: Colors.red),
              ),
              actions: [
                ElevatedButton(
                    onPressed: () {
                      onNointernetOKPressed();
                    },
                    child: const Text(
                      "OK",
                    ))
              ],
            ),
          );
        break;
    }
    lastResult = status;
  }

  @override
  Widget build(BuildContext context) {
    final statusAsync = ref.watch(internetCheckPod);
    ref.listen<AsyncValue<InternetConnectionStatus>>(internetCheckPod,
        (previous, next) {
      final status = next.value;
      if (status != null) {
        internetListener(
          status,
          onNointernetOKPressed: () {
            ref.invalidate(internetCheckPod);
          },
        );
      }
    });

    return Scaffold(
      body: !kIsWeb
          ? statusAsync.when(
              data: (status) {
                switch (status) {
                  case InternetConnectionStatus.connected:
                    return widget.child;
                  case InternetConnectionStatus.disconnected:
                    return <Widget>[
                      const RiveAnimation.asset(
                        "assets/animations/nointernet.riv",
                        fit: BoxFit.cover,
                      ).box.height(context.screenHeight).make(),
                    ].stack(clip: Clip.none);
                }
              },
              error: (error, stackTrace) => Center(
                    child: Text(error.toString()),
                  ),
              loading: () => const Center(child: CircularProgressIndicator()))
          : widget.child,
    );
  }
}

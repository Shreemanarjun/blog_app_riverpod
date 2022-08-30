import 'package:flutter/material.dart';
import 'package:let_log/let_log.dart';
import 'package:platform_info/platform_info.dart';
import 'package:velocity_x/velocity_x.dart';

Future<void> showLoadingDialog(
    {required BuildContext context, required String title}) async {
  platform.when(
    mobile: () async {
      await hideDialog(context: context);
      Logger.log("dialog showing");
      await showDialog(
          context: context,
          builder: (context) => Dialog(
                backgroundColor: Colors.white.withOpacity(0.9),
                elevation: 0,
                child: [
                  const CircularProgressIndicator(),
                  8.heightBox,
                  title.text.make(),
                ].vStack().p12(),
              ));
    },
    desktop: () async {
      await hideDialog(context: context);
      Logger.log("dialog showing");
      await showDialog(
          context: context,
          useRootNavigator: false,
          builder: (context) => Dialog(
                backgroundColor: Colors.white.withOpacity(0.9),
                elevation: 0,
                child: [
                  const CircularProgressIndicator(),
                  8.heightBox,
                  title.text.make(),
                ].vStack().p12(),
              ));
    },
    web: () async {
      await hideDialog(context: context);
      Logger.log("dialog showing");
      await showDialog(
          context: context,
          builder: (context) => Dialog(
                backgroundColor: Colors.white.withOpacity(0.9),
                elevation: 0,
                child: [
                  const CircularProgressIndicator(),
                  8.heightBox,
                  title.text.make(),
                ].vStack().p12(),
              ));
    },
  );
}

Future<void> hideDialog({required BuildContext context}) async {
  platform.when(
    mobile: () async {
      if (Navigator.of(context).canPop()) {
        await Navigator.of(context).maybePop();
      }
    },
    desktop: () async {
      if (Navigator.of(context).canPop()) {
        await Navigator.of(context).maybePop();
      }
    },
    web: () async {
      if (Navigator.of(context).canPop()) {
        await Navigator.of(context).maybePop();
      }
    },
  );
}

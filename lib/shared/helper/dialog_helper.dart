import 'package:flutter/material.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

Future<void> showLoadingDialog(
    {required BuildContext context, required String title}) async {
  final talker = Talker();
  await hideDialog(context: context);
  talker.log("dialog showing");
  if (context.mounted) {
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
  }
}

Future<void> hideDialog({required BuildContext context}) async {
  if (Navigator.of(context).canPop()) {
    await Navigator.of(context).maybePop();
  }
}

import 'package:blog_app_riverpod/routes/router.gr.dart';
import 'package:blog_app_riverpod/routes/router_pod.dart';
import 'package:blog_app_riverpod/shared/riverpod/db_service_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

void showUnauthorizedDialog(BuildContext context, WidgetRef ref) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: "Invalid Credential.Please Relogin".text.isIntrinsic.make(),
      actions: [
        TextButton(
            onPressed: () {
              onLogout(ref);
            },
            child: "Relogin".text.isIntrinsic.make())
      ],
    ),
  );
}

void onLogout(WidgetRef ref) async {
  await ref.read(dbServiceProvider).removeTokenModel();
  ref.read(autorouterProvider).replaceAll([const LoginRouter()]);
}

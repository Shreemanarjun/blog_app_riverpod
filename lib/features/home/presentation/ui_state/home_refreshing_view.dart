import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_loaded_view.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeRefreshingView extends StatelessWidget {
  final BlogsModel blogmodel;
  const HomeRefreshingView({Key? key, required this.blogmodel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: 100),
            duration: const Duration(seconds: 5),
            builder: (context, value, child) {
              return LinearProgressIndicator(
                value: value / 100,
                minHeight: 8,
                valueColor: const AlwaysStoppedAnimation(Vx.green400),
                backgroundColor: Colors.transparent,
              );
            }),
        Flexible(
            child: HomeLoadedView(
          blogmodel: blogmodel,
        )),
      ],
    );
  }
}

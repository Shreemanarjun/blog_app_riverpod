import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

class BlogAddedView extends StatelessWidget {
  const BlogAddedView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: "Blog added ✅".text.lg.makeCentered());
  }
}

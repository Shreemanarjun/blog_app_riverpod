import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/features/home/controller/home_provider.dart';
import 'package:blog_app_riverpod/features/update_blog/presentation/update_blog_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeLoadedView extends ConsumerWidget {
  final BlogsModel blogmodel;
  const HomeLoadedView({Key? key, required this.blogmodel}) : super(key: key);

  void updateBlogView(BuildContext context, BlogModel blogModel) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (mcontext) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.6 +
                  MediaQuery.of(context).viewInsets.bottom,
              child: UpdateBlogView(blogModel),
            ));
  }

  @override
  Widget build(BuildContext context, ref) {
    return blogmodel.blogs.isNotEmpty
        ? [
            Flexible(
              child: RefreshIndicator(
                onRefresh: () => ref.read(homeprovider.notifier).refreshBlogs(),
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    final blog = blogmodel.blogs[index];
                    return ListTile(
                      leading: blog.id.text.make(),
                      title: blog.title.text.make(),
                     
                      tileColor: Vx.gray300,
                  //    isThreeLine: true,
                      trailing: [
                        IconButton(
                            onPressed: () => updateBlogView(context, blog),
                            icon: const Icon(
                              Icons.edit,
                              color: Vx.green600,
                            )),
                        IconButton(
                            onPressed: () => ref
                                .read(homeprovider.notifier)
                                .deleteBlog(id: blog.id.toString()),
                            icon: const Icon(
                              Icons.delete_forever_outlined,
                              color: Vx.red500,
                            )),
                      ].hStack(),
                    ).card.make().p8();
                  },
                  itemCount: blogmodel.blogs.length,
                ),
              ),
            )
          ].vStack().centered()
        : [
            Flexible(
              child: TextButton.icon(
                onPressed: () => ref.read(homeprovider.notifier).refreshBlogs(),
                icon: const Icon(
                  Icons.refresh_outlined,
                  color: Vx.white,
                ).circle(
                  backgroundColor: Vx.green500,
                  radius: 32,
                ),
                label: "No Blogs Yet .\nClick Here to Refresh".text.make(),
              ),
            ),
          ].vStack().centered();
  }
}

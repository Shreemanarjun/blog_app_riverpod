import 'package:blog_app_riverpod/features/add_blog/presentation/add_blog_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_error_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_initial_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_loaded_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_loading_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_refreshing_view.dart';
import 'package:blog_app_riverpod/features/home/riverpod/home_provider.dart';
import 'package:blog_app_riverpod/features/home/state/home_states.dart';
import 'package:blog_app_riverpod/shared/helper/dialog_helper.dart';
import 'package:blog_app_riverpod/shared/helper/unauthorized_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:velocity_x/velocity_x.dart';

class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  void statelistener(HomeState? previous, HomeState next, BuildContext context,
      WidgetRef ref) async {
    if (next is HomeUnauthorized) {
      showUnauthorizedDialog(context, ref);
    } else if (previous is HomeRefreshing && next is HomeLoaded) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Blogs Refreshed 😍 !".text.make()));
    } else if (previous is HomeLoaded && next is HomeRefreshing) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Refreshing Blogs 🔃".text.make()));
    } else if (previous is HomeRefreshError && next is HomeLoaded) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: "Refreshed .No new blogs 😢!".text.make()));
    } else if (next is HomeBlogDeleting) {
      await showLoadingDialog(context: context, title: 'Deleting a blog');
    } else if (next is HomeBlogDeleted) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: "Deleted... ❎".text.make()));
    } else if (next is HomeLoaded) {
      await hideDialog(context: context);
    }
  }

  void addABlogPage(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (mcontext) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.6 +
                  MediaQuery.of(context).viewInsets.bottom,
              child: const AddBlogView(),
            ));
  }

  @override
  Widget build(BuildContext context, ref) {
    final homeState = ref.watch(homeprovider);

    ref.listen<HomeState>(
      homeprovider,
      (previous, next) => statelistener(previous, next, context, ref),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs'),
        actions: [
          IconButton(
              onPressed: () => onLogout(ref),
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => addABlogPage(context),
        child: const Icon(Icons.add),
      ),
      body: homeState.map(
        homeInitial: (s) => const HomeInitialView(),
        homeLoading: (s) => const HomeLoadingView(),
        homeLoaded: (s) => HomeLoadedView(blogmodel: s.blogmodel),
        homeRefreshing: (s) => HomeRefreshingView(blogmodel: s.blogmodel),
        homeError: (s) =>
            HomeErrorView(message: s.message, details: s.details ?? ""),
        homeRefreshError: (s) => HomeLoadedView(blogmodel: s.blogmodel),
        homeUnauthorized: (s) => const HomeInitialView(),
        homeBlogDeleted: (s) => HomeLoadedView(blogmodel: s.blogmodel),
        homeBlogDeleting: (s) => HomeRefreshingView(blogmodel: s.blogmodel),
      ),
    );
  }
}

import 'package:auto_route/auto_route.dart';
import 'package:blog_app_riverpod/features/add_blog/controller/add_blog_provider.dart';
import 'package:blog_app_riverpod/features/add_blog/presentation/add_blog_view.dart';
import 'package:blog_app_riverpod/features/add_blog/state/blog_add_state.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_error_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_initial_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_loaded_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_loading_view.dart';
import 'package:blog_app_riverpod/features/home/presentation/ui_state/home_refreshing_view.dart';
import 'package:blog_app_riverpod/features/home/controller/home_provider.dart';
import 'package:blog_app_riverpod/features/home/state/home_states.dart';
import 'package:blog_app_riverpod/features/update_blog/controller/blog_update_provider.dart';
import 'package:blog_app_riverpod/features/update_blog/state/blog_update_state.dart';
import 'package:blog_app_riverpod/main.dart';
import 'package:blog_app_riverpod/shared/helper/dialog_helper.dart';
import 'package:blog_app_riverpod/shared/helper/unauthorized_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:talker_flutter/talker_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

@RoutePage(name: 'HomeRouter', deferredLoading: true)
class HomeView extends ConsumerWidget {
  const HomeView({Key? key}) : super(key: key);

  void statelistener(AsyncValue? prev, AsyncValue nxt, BuildContext context,
      WidgetRef ref) async {
    final previous = prev?.value;
    final next = nxt.value;
    if (next is AsyncData<HomeUnauthorized>) {
      showUnauthorizedDialog(context, ref);
    } else if (previous is HomeRefreshing && next is HomeLoaded) {
      if (previous.blogmodel == next.blogmodel) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
              SnackBar(content: "Refreshed .No new blogs 😢!".text.make()));
      } else {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(SnackBar(content: "Blogs Refreshed 😍 !".text.make()));
      }
    } else if (previous is HomeLoaded && next is HomeRefreshing) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: "Refreshing Blogs 🔃".text.make()));
    } else if (previous is HomeRefreshError && next is HomeLoaded) {
      if (previous.blogmodel == next.blogmodel) {
        ScaffoldMessenger.of(context)
          ..clearSnackBars()
          ..showSnackBar(
              SnackBar(content: "Refreshed .No new blogs 😢!".text.make()));
      }
    } else if (next is HomeBlogDeleting) {
      await showLoadingDialog(context: context, title: 'Deleting a blog');
    } else if (next is HomeBlogDeleted) {
      ScaffoldMessenger.of(context)
        ..clearSnackBars()
        ..showSnackBar(SnackBar(content: "Deleted... ❎".text.make()));
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
    ref.listen<AddBlogState>(addBlogProvider, (previous, next) {
      if (next is BlogAdded) {
        Future.delayed(const Duration(seconds: 2), () {
          ref.watch(homeprovider.notifier).refreshBlogs();
        });
      }
    });
    ref.listen<UpdateBlogState>(
      updateBlogProvider,
      (previous, next) {
        if (next is BlogUpdated) {
          Future.delayed(const Duration(seconds: 2), () {
            ref.watch(homeprovider.notifier).refreshBlogs();
          });
        }
      },
    );

    ref.listen<AsyncValue>(
      homeprovider,
      (previous, next) => statelistener(previous, next, context, ref),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Text('Blogs'),
          actions: [
            IconButton(
                onPressed: () {


                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => TalkerScreen(talker: talker),
                  ));
                },
                icon: const Icon(Icons.info_outline)),
            IconButton(
                onPressed: () => onLogout(ref),
                icon: const Icon(Icons.logout_outlined))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => addABlogPage(context),
          child: const Icon(Icons.add),
        ),
        body: Consumer(builder: (context, ref, child) {
          final blogsAsync = ref.watch(homeprovider);
          return blogsAsync.when(
            data: (homeState) {
              return homeState
                  .map(
                    homeInitial: (s) => const HomeInitialView(),
                    homeLoading: (s) => const HomeLoadingView(),
                    homeLoaded: (s) => HomeLoadedView(blogmodel: s.blogmodel),
                    homeRefreshing: (s) =>
                        HomeRefreshingView(blogmodel: s.blogmodel),
                    homeError: (s) => HomeErrorView(
                        message: s.message, details: s.details ?? ""),
                    homeRefreshError: (s) =>
                        HomeLoadedView(blogmodel: s.blogmodel),
                    homeUnauthorized: (s) => const HomeInitialView(),
                    homeBlogDeleted: (s) =>
                        HomeLoadedView(blogmodel: s.blogmodel),
                    homeBlogDeleting: (s) =>
                        HomeRefreshingView(blogmodel: s.blogmodel),
                  )
                  .safeArea();
            },
            error: (error, stackTrace) =>
                HomeErrorView(message: error.toString(), details: ""),
            loading: () => const CircularProgressIndicator().centered(),
          );
        }));
  }
}

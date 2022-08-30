import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/data/repositories/blog/i_blog_repository.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';
import 'package:blog_app_riverpod/features/home/state/home_states.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:blog_app_riverpod/shared/riverpod/history_mixin.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:let_log/let_log.dart';

class HomeStateNotifier extends StateNotifier<HomeState>
    with HistoryMixin<HomeState> {
  final IBlogRepository blogRepository;
  final IDbService dbService;

  HomeStateNotifier(this.blogRepository, this.dbService) : super(HomeInitial());

  Future<void> getAllBlogs() async {
    Logger.log("called get all blogs");
    try {
      state = HomeLoading(getCurrentBlogs());
      final result = await blogRepository.getAllBlogs();
      result.when((error) {
        if (error is UnauthorizedException) {
          state = HomeUnauthorized();
        } else {
          state = HomeError(message: error.message, details: "");
        }
      }, (blogs) {
        state = HomeLoaded(blogs);
      });
    } on DioError catch (e) {
      state = HomeError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = HomeError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }

  Future<void> refreshBlogs() async {
    Logger.log("called refresh all blogs");
    final currentblogs = getCurrentBlogs();
    try {
      ///populate blogs while refreshing
      state = HomeRefreshing(currentblogs);
      final result = await blogRepository.getAllBlogs();
      result.when((error) {
        if (error is UnauthorizedException) {
          state = HomeUnauthorized();
        } else {
          state = HomeRefreshError(currentblogs);
          state = HomeLoaded(currentblogs);
        }
      }, (blogs) {
        if (blogs != currentblogs) {
          state = HomeLoaded(blogs);
        } else {
          state = HomeRefreshError(currentblogs);
          state = HomeLoaded(blogs);
        }
      });
    } on DioError catch (e) {
      state = HomeError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = HomeError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }

  Future<void> deleteBlog({required String id}) async {
    final currentblogs = getCurrentBlogs();
    try {
      state = HomeBlogDeleting(currentblogs);
      final result = await blogRepository.deleteBlogByID(id: id);
      result.when((error) {
        if (error is UnauthorizedException) {
          state = HomeUnauthorized();
        } else {
          state = HomeRefreshError(currentblogs);
        }
      }, (isDeleted) async {
        state = HomeBlogDeleted(currentblogs);
        final result = await blogRepository.getAllBlogs();
        result.when((error) {
          if (error.message == 'Unauthorized') {
            state = HomeUnauthorized();
          } else {
            state = HomeError(message: error.message, details: "");
          }
        }, (blogs) {
          state = HomeLoaded(blogs);
        });
      });
    } on DioError catch (e) {
      state = HomeError(message: e.message, details: e.response.toString());
    } catch (e) {
      state = HomeError(message: "Unknown Error ${e.toString()}", details: "");
    }
  }

  void changeStatusToInitial() {
    state = HomeInitial();
  }

  BlogsModel getCurrentBlogs() {
    if (state is HomeLoaded) {
      //get all current blogs
      final currentblogs = (state as HomeLoaded).blogmodel;
      return currentblogs;
    }
    return BlogsModel(blogs: []);
  }
}

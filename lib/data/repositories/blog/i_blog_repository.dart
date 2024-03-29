import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/data/models/create_blog_response.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:dio/dio.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IBlogRepository {
  Future<Result<BaseException, BlogsModel>> getAllBlogs(
      {CancelToken? cancelToken});
  Future<Result<BaseException, BlogsModel>> getBlogByID({required String id});
  Future<Result<BaseException, CreateBlogResponseModel>> createBlog(
      {required String title, required String description});
  Future<Result<BaseException, bool>> updateBlogByID(
      {required String id, required String title, required String description});
  Future<Result<BaseException, bool>> deleteBlogByID({required String id});
}

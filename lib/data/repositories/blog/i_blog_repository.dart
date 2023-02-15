import 'package:blog_app_riverpod/data/models/blogs_model.dart';
import 'package:blog_app_riverpod/data/models/create_blog_response.dart';
import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';
import 'package:multiple_result/multiple_result.dart';

abstract class IBlogRepository {
  Future<Result<BaseException, BlogsModel>> getAllBlogs();
  Future<Result<BaseException, BlogModel>> getBlogByID({required String id});
  Future<Result<BaseException, CreateBlogResponseModel>> createBlog(
      {required String title});
  Future<Result<BaseException, bool>> updateBlogByID(
      {required String id, required String title});
  Future<Result<BaseException, bool>> deleteBlogByID({required String id});
}

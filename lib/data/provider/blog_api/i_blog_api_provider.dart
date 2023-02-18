import 'package:dio/dio.dart';

abstract class IBlogApiProvider {
  Future<Response> getAllBlogs({CancelToken? cancelToken});
  Future<Response> getBlogByID({required String id});
  Future<Response> createBlog({required String title});
  Future<Response> updateBlogByID(
      {required String id, required String title});
  Future<Response> deleteBlogByID({required String id});
}

import 'package:dio/dio.dart';

abstract class IBlogApiProvider {
  Future<Response> getAllBlogs();
  Future<Response> getBlogByID({required String id});
  Future<Response> createBlog({required String title, required String body});
  Future<Response> updateBlogByID(
      {required String id, required String title, required String body});
  Future<Response> deleteBlogByID({required String id});
}

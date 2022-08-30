import 'package:blog_app_riverpod/data/const/app_urls.dart';
import 'package:blog_app_riverpod/data/provider/blog_api/interceptor/blog_interceptor.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';

import 'package:dio/dio.dart';

import 'i_blog_api_provider.dart';

class BlogApiProvider implements IBlogApiProvider {
  final IDbService dbService;
  final Dio dio;
  BlogApiProvider({required this.dbService, required this.dio}) {
    dio.interceptors.add(
      BlogInteceptor(
        dio: dio,
        dbService: dbService,
      ),
    );
  }
  @override
  Future<Response> createBlog({required String title, required String body}) {
    return dio.post(AppURLs.createBlogURl, data: {
      "title": title,
      "body": body,
    });
  }

  @override
  Future<Response> deleteBlogByID({required String id}) {
    return dio.delete(
      "${AppURLs.deleteABlog}$id",
    );
  }

  @override
  Future<Response> getAllBlogs() {
    return dio.get(AppURLs.getAllBlogUrl);
  }

  @override
  Future<Response> getBlogByID({required String id}) {
    return dio.get(AppURLs.getABlog + id);
  }

  @override
  Future<Response> updateBlogByID(
      {required String id, required String title, required String body}) {
    return dio.put(AppURLs.updateABlog + id, data: {
      "title": title,
      "body": body,
    });
  }
}

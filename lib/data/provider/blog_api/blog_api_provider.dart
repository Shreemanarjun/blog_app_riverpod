import 'package:blog_app_riverpod/data/const/app_urls.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';

import 'package:dio/dio.dart';

import 'i_blog_api_provider.dart';

class BlogApiProvider implements IBlogApiProvider {
  final IDbService dbService;
  final Dio dio;
  BlogApiProvider({required this.dbService, required this.dio});

  @override
  Future<Response> createBlog({required String title}) {
    return dio.post(AppURLs.createBlogURl, data: {
      "title": title,
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
  Future<Response> updateBlogByID({required String id, required String title}) {
    return dio.patch(AppURLs.updateABlog, data: {
      "blogId": id,
      "title": title,
    });
  }
}

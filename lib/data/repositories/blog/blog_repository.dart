import 'package:blog_app_riverpod/data/models/validation_error_model.dart';
import 'package:blog_app_riverpod/data/provider/blog_api/i_blog_api_provider.dart';
import 'package:blog_app_riverpod/shared/exceptions/no_internet_exception.dart';
import 'package:multiple_result/multiple_result.dart';

import 'package:blog_app_riverpod/shared/exceptions/base_exception.dart';

import 'package:blog_app_riverpod/data/models/create_blog_response.dart';

import 'package:blog_app_riverpod/data/models/blogs_model.dart';

import 'i_blog_repository.dart';

class BlogRepository implements IBlogRepository {
  final IBlogApiProvider blogApiProvider;
  BlogRepository({required this.blogApiProvider});
  @override
  Future<Result<BaseException, CreateBlogResponseModel>> createBlog(
      {required String title, required String body}) async {
    final result = await blogApiProvider.createBlog(title: title, body: body);

    if (result.statusCode == 200 || result.statusCode == 201) {
      try {
        return Success(CreateBlogResponseModel.fromMap(result.data));
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (result.statusCode == 401) {
      return Error(UnauthorizedException(message: result.data.toString()));
    } else if (result.statusCode == 422) {
      final validationerror = ValidationError.fromMap(result.data);
      return Error(
          ValidationException(message: validationerror.detail.toString()));
    } else {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }

  @override
  Future<Result<BaseException, bool>> deleteBlogByID(
      {required String id}) async {
    final result = await blogApiProvider.deleteBlogByID(id: id);
    if (result.statusCode == 204) {
      try {
        return const Success(true);
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (result.statusCode == 401) {
      return Error(UnauthorizedException(message: result.data.toString()));
    } else if (result.statusCode == 422) {
      final validationerror = ValidationError.fromMap(result.data);
      return Error(
          ValidationException(message: validationerror.detail.toString()));
    } else {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }

  @override
  Future<Result<BaseException, BlogsModel>> getAllBlogs() async {
    final result = await blogApiProvider.getAllBlogs();
    if (result.statusCode == 200) {
      try {
        return Success(BlogsModel.fromMap(result.data));
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (result.statusCode == 401) {
      return Error(UnauthorizedException(message: result.data.toString()));
    } else if (result.statusCode == 422) {
      final validationerror = ValidationError.fromMap(result.data);
      return Error(
          ValidationException(message: validationerror.detail.toString()));
    } else {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }

  @override
  Future<Result<BaseException, BlogModel>> getBlogByID(
      {required String id}) async {
    final result = await blogApiProvider.getBlogByID(id: id);
    if (result.statusCode == 200) {
      try {
        return Success(BlogModel.fromMap(result.data));
      } catch (e) {
        return Error(BaseException(message: e.toString()));
      }
    } else if (result.statusCode == 401) {
      return Error(UnauthorizedException(message: result.data.toString()));
    } else if (result.statusCode == 422) {
      final validationerror = ValidationError.fromMap(result.data);
      return Error(
          ValidationException(message: validationerror.detail.toString()));
    } else {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }

  @override
  Future<Result<BaseException, bool>> updateBlogByID(
      {required String id, required String title, required String body}) async {
    final result =
        await blogApiProvider.updateBlogByID(id: id, title: title, body: body);
    if (result.statusCode == 202) {
      return const Success(true);
    } else if (result.statusCode == 401) {
      return Error(UnauthorizedException(message: result.data.toString()));
    } else if (result.statusCode == 422) {
      final validationerror = ValidationError.fromMap(result.data);
      return Error(
          ValidationException(message: validationerror.detail.toString()));
    } else {
      final details = result.data['detail'];
      if (details == 'No Internet') {
        throw NoInternetException();
      } else {
        return Error(BaseException(message: details));
      }
    }
  }
}

import 'package:dio/dio.dart';

abstract class ILoginProvider {
  Future<Response> loginUser(
      {required String username, required String password});
  Future<Response> signUpUser(
      {required String name, required String email, required String password});
}

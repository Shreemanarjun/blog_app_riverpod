import 'package:blog_app_riverpod/data/models/login_model.dart';


abstract class IDbService {
  Future<void> saveLoginModel({required LoginModel loginModel});
  Future<LoginModel?> readLoginModel();
  Future<void> removeLoginModel();
}

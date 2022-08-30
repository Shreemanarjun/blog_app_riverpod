import 'package:blog_app_riverpod/data/models/login_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'i_db_service.dart';

class DbService implements IDbService {
  @override
  Future<LoginModel?> readLoginModel() async {
    final loginBox = await Hive.openBox('login');
    var modelJson = await loginBox.get('login');
    if (modelJson != null) {
      return LoginModel.fromJson(modelJson);
    }
    return null;
  }

  @override
  Future<void> saveLoginModel({required LoginModel loginModel}) async {
    final loginBox = await Hive.openBox('login');
    await loginBox.put('login', loginModel.toJson());
  }

  @override
  Future<void> removeLoginModel() async {
    final loginBox = await Hive.openBox('login');
    await loginBox.delete('login');
  }
}

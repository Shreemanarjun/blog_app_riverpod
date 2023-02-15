import 'package:blog_app_riverpod/data/models/token_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'i_db_service.dart';

class DbService implements IDbService {
  final tokenBox = "tokenBox";
  final tokenkey = "token";
  @override
  Future<TokenModel?> getTokenModel() async {
    final loginBox = await Hive.openBox(tokenBox);
    var modelJson = await loginBox.get(tokenkey);
    if (modelJson != null) {
      return TokenModel.fromJson(modelJson);
    }
    return null;
  }

  @override
  Future<void> saveTokenModel({required TokenModel tokenModel}) async {
    final loginBox = await Hive.openBox(tokenBox);
    await loginBox.put(tokenkey, tokenModel.toJson());
  }

  @override
  Future<void> removeTokenModel() async {
    final loginBox = await Hive.openBox(tokenBox);
    await loginBox.delete(tokenkey);
  }
}

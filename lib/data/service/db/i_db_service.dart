
import 'package:blog_app_riverpod/data/models/token_model.dart';


abstract class IDbService {
  Future<void> saveTokenModel({required TokenModel tokenModel});
  Future<TokenModel?> getTokenModel();
  Future<void> removeTokenModel();
}

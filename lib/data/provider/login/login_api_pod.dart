import 'package:blog_app_riverpod/data/provider/login/i_login_provider.dart';
import 'package:blog_app_riverpod/data/provider/login/login_provider.dart';
import 'package:blog_app_riverpod/shared/dio_client/dio_provider.dart';
import 'package:blog_app_riverpod/shared/pods/db_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myloginProvider = Provider.autoDispose<ILoginProvider>((ref) =>
    LoginProvider(
        dbService: ref.watch(dbServiceProvider), dio: ref.watch(dioProvider)));
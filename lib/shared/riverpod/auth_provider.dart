import 'package:blog_app_riverpod/features/login/riverpod/notifier/auth_notifier.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final authProvider =
    ChangeNotifierProvider.autoDispose<AuthNotifier>((ref) => AuthNotifier());

import 'package:blog_app_riverpod/routes/router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final autorouterProvider = Provider.autoDispose(
  (ref) => AppRouter(),
);

import 'package:blog_app_riverpod/data/service/db/db_service.dart';
import 'package:blog_app_riverpod/data/service/db/i_db_service.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final dbServiceProvider = Provider.autoDispose<IDbService>(
  (ref) {
    return DbService();
  },
);

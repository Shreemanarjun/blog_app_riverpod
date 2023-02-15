import 'package:auto_route/auto_route.dart';
import 'package:blog_app_riverpod/data/service/db/db_service.dart';

class TokenGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final dbService = DbService();
    final tokenmodel = await dbService.getTokenModel();
    if (tokenmodel != null) {
      resolver.next();
    } else {
      resolver.next(false);
    }
  }
}

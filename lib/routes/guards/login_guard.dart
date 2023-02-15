import 'package:auto_route/auto_route.dart';
import 'package:blog_app_riverpod/data/service/db/db_service.dart';
import 'package:blog_app_riverpod/routes/router.gr.dart';

class LoginGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final dbService = DbService();
    final tokenmodel = await dbService.getTokenModel();
    if (tokenmodel != null) {
      router.replaceAll([const HomeRouter()]);
    } else {
      resolver.next();
    }
  }
}

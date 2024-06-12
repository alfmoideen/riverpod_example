import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/core/router/app_router_notifier.dart';
import 'package:parking_app/core/router/named_route.dart';
import 'package:parking_app/feature/product/presentation/ui/product_page.dart';
import 'package:parking_app/feature/sign_in/presentation/ui/sign_in.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey();

final appRouterProvider = Provider<GoRouter>((ref) {
  final notifier = ref.read(appRouterNotifierProvider);

  return GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/login',
    refreshListenable: notifier,
    routes: <RouteBase>[
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: '/login',
        name: login,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: LoginPage(
            key: state.pageKey,
          ),
        ),
      ),
      GoRoute(
        parentNavigatorKey: navigatorKey,
        path: '/product',
        name: product,
        pageBuilder: (context, state) => CupertinoPage(
          key: state.pageKey,
          child: ProductScreen(
            key: state.pageKey,
          ),
        ),
      ),
    ],
  );
});

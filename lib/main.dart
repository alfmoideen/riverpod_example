import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/core/router/app_router.dart';

ProviderContainer _providerContainer = ProviderContainer();

ProviderContainer get providerContainer => _providerContainer;
void main() {
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRoute = ref.watch(appRouterProvider);
    return MaterialApp.router(
      title: 'Flutter Riverpod Demo',
      debugShowCheckedModeBanner: false,
      routerDelegate: appRoute.routerDelegate,
      routeInformationParser: appRoute.routeInformationParser,
      routeInformationProvider: appRoute.routeInformationProvider,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

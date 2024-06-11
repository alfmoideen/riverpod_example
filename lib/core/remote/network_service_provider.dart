import 'package:dio/dio.dart';
import 'package:dio_http_formatter/dio_http_formatter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/core/providers/base_url.dart';

import 'network_service_interceptor.dart';

//Provider for the network service

final networkServiceProvider = Provider<Dio>((ref) {
  final baseUrl = ref.watch(baseUrlProvider);

  final dioOptions = BaseOptions(
    baseUrl: baseUrl,
    connectTimeout: const Duration(minutes: 1),
    receiveTimeout: const Duration(minutes: 1),
    sendTimeout: const Duration(minutes: 1),
  );

  return Dio(dioOptions)
    ..interceptors.addAll([
      HttpFormatter(),
      NetWorkServiceInterceptor(),
    ]);
});

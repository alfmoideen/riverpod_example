// ignore_for_file: unnecessary_overrides

import 'package:dio/dio.dart';
import 'package:parking_app/core/dependencies/authentication/auth_provider.dart';
import 'package:parking_app/main.dart';

class NetWorkServiceInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final idToken = providerContainer.read(authTokenProvider.notifier).state;
    options.headers['Accept'] = 'application/json';
    options.headers['Content-Type'] = 'application/json';
    if (idToken.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $idToken';
    }
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    super.onError(err, handler);
  }
}

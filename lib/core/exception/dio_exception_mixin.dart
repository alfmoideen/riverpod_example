import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';

import 'failure.dart';

mixin DioExceptionMixin {
  Future<T> callApi<T>(FutureOr<T> Function() call) async {
    try {
      return await call();
    } on DioException catch (e, s) {
      if (e.error is SocketException) {
        throw Failure(
          message: e.message,
          statusCode: e.response?.statusCode,
          exception: e,
          stackTrace: s,
        );
      }

      if (e.response?.statusCode == 400) {
        throw Failure(
          message: e.response?.data['error'].toString() ?? '',
          statusCode: e.response?.statusCode,
          exception: e,
          stackTrace: s,
        );
      }

      if (e.response?.statusCode == 401) {
        throw Failure(
          message: e.response?.data['error'].toString() ?? '',
          statusCode: e.response?.statusCode,
          exception: e,
          stackTrace: s,
        );
      }

      if (e.response?.statusCode == 422) {
        throw Failure(
          message: e.response?.data['error'].toString() ?? '',
          statusCode: e.response?.statusCode,
          exception: e,
          stackTrace: s,
        );
      }

      if (e.response?.statusCode == 500) {
        throw Failure(
          message: e.response?.data['error'].toString() ?? '',
          statusCode: e.response?.statusCode,
          exception: e,
          stackTrace: s,
        );
      }

      throw Failure(
        message: e.response?.data['error'].toString() ??
            e.response?.statusMessage ??
            'Something went wrong: ${e.error} : ${e.response?.statusCode}',
        statusCode: e.response?.statusCode,
        exception: e,
        stackTrace: s,
      );
    }
  }
}

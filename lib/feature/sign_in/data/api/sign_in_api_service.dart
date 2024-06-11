// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import 'package:parking_app/core/remote/network_service_provider.dart';
import 'package:parking_app/feature/sign_in/data/dto/request/sign_in/sign_in_request.dart';
import 'package:parking_app/feature/sign_in/data/dto/response/sign_in/sign_in_response.dart';
import 'package:retrofit/retrofit.dart';

part 'sign_in_api_service.g.dart';

final signInApiServiceProvider = Provider<SignInApiService>((ref) {
  final dioService = ref.watch(networkServiceProvider);
  return SignInApiService(dioService);
});

@RestApi()
abstract class SignInApiService {
  factory SignInApiService(Dio dio) => _SignInApiService(dio);

  @POST('auth/login')
  Future<SignInResponse> login(@Body() SignInRequest request);
}

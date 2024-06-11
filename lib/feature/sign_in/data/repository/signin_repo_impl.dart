import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:parking_app/core/exception/dio_exception_mixin.dart';
import 'package:parking_app/core/exception/failure.dart';
import 'package:parking_app/feature/sign_in/data/api/sign_in_api_service.dart';
import 'package:parking_app/feature/sign_in/data/dto/request/sign_in/sign_in_request.dart';
import 'package:parking_app/feature/sign_in/data/dto/response/sign_in/sign_in_response.dart';

import 'signin_repository.dart';

final signInRepositoryProvider = Provider<SignInRepoImpl>((ref) {
  final signInApiService = ref.watch(signInApiServiceProvider);
  return SignInRepoImpl(signInApiService);
});

class SignInRepoImpl with DioExceptionMixin implements SignInRepository {
  final SignInApiService _signInApiService;

  SignInRepoImpl(this._signInApiService);

  @override
  Future<Result<SignInResponse, Failure>> login(
      SignInRequest loginParams) async {
    try {
      SignInResponse response = await _signInApiService.login(loginParams);
      return Success(response);
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(Failure(exception: Exception(e), message: e.toString()));
    }
  }
}

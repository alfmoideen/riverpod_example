import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:multiple_result/multiple_result.dart';
import 'package:parking_app/core/exception/failure.dart';
import 'package:parking_app/feature/sign_in/application/sign_in_service.dart';
import 'package:parking_app/feature/sign_in/data/dto/request/sign_in/sign_in_request.dart';
import 'package:parking_app/feature/sign_in/data/dto/response/sign_in/sign_in_response.dart';
import 'package:parking_app/feature/sign_in/data/repository/signin_repo_impl.dart';
import 'package:parking_app/feature/sign_in/data/repository/signin_repository.dart';

final signInServiceProvider = Provider<SignInServiceImpl>((ref) {
  final signInApiService = ref.watch(signInRepositoryProvider);
  return SignInServiceImpl(signInApiService);
});

class SignInServiceImpl implements SignInService {
  final SignInRepository signInRepository;
  SignInServiceImpl(this.signInRepository);

  @override
  Future<Result<SignInResponse, Failure>> login({
    required String username,
    required String password,
  }) async {
    try {
      Result<SignInResponse, Failure> result = await signInRepository.login(
        SignInRequest(
          password: password,
          username: username,
        ),
      );
      if (result is Success<SignInResponse, Failure>) {
        return Success(result.success);
      } else {
        return Error(Failure(message: result.toString()));
      }
    } on Failure catch (e) {
      return Error(e);
    } catch (e) {
      return Error(Failure(exception: Exception(e), message: e.toString()));
    }
  }
}

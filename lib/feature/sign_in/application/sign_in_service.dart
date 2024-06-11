import 'package:multiple_result/multiple_result.dart';
import 'package:parking_app/core/exception/failure.dart';
import 'package:parking_app/feature/sign_in/data/dto/response/sign_in/sign_in_response.dart';

abstract interface class SignInService {
  Future<Result<SignInResponse, Failure>> login({
    required String username,
    required String password,
  });
}

import 'package:multiple_result/multiple_result.dart';
import 'package:parking_app/core/exception/failure.dart';
import 'package:parking_app/feature/sign_in/data/dto/request/sign_in/sign_in_request.dart';
import 'package:parking_app/feature/sign_in/data/dto/response/sign_in/sign_in_response.dart';

abstract interface class SignInRepository {
  Future<Result<SignInResponse, Failure>> login(SignInRequest loginParams);
}

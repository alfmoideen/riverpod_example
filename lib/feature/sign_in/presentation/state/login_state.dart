import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:parking_app/feature/sign_in/presentation/ui/sign_in.dart';

part 'login_state.freezed.dart';

@freezed
class LoginState with _$LoginState {
  const factory LoginState({
    @Default(LoginStatus.idle) final LoginStatus loginStatus,
    @Default('') final String errorMessage,
    @Default('') final String token,
    @Default(AsyncData(false)) final AsyncValue<bool> isLoginComplete,
  }) = _LoginState;
}

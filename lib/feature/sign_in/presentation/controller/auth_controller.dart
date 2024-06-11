import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/feature/sign_in/application/sign_in_service.dart';
import 'package:parking_app/feature/sign_in/application/sign_in_service_impl.dart';
import 'package:parking_app/feature/sign_in/presentation/state/login_state.dart';
import 'package:parking_app/feature/sign_in/presentation/ui/sign_in.dart';

final authProvider = StateNotifierProvider<AuthNotifier, LoginState>((ref) {
  final authService = ref.watch(signInServiceProvider);
  return AuthNotifier(authService, const LoginState());
});

class AuthNotifier extends StateNotifier<LoginState> {
  AuthNotifier(this.authService, super.state);

  final SignInService authService;

  Future<void> login({
    required String username,
    required String password,
  }) async {
    state = state.copyWith(
      loginStatus: LoginStatus.loading,
      token: '',
      errorMessage: '',
    );
    try {
      final loginResult =
          await authService.login(username: username, password: password);
      loginResult.when(
        (success) {
          state = state.copyWith(
            loginStatus: LoginStatus.loginSuccess,
            token: success.token,
            errorMessage: '',
          );
        },
        (error) {
          state = state.copyWith(
            loginStatus: LoginStatus.loginFailed,
            errorMessage: error.toString(),
            token: '',
          );
        },
      );
    } catch (e) {
      state = state.copyWith(
        loginStatus: LoginStatus.loginFailed,
        errorMessage: '$e',
        token: '',
      );
    }
  }
}

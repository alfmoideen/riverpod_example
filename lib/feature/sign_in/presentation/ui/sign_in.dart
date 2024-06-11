// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/feature/sign_in/presentation/controller/auth_controller.dart';

class LoginPage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final loginState = ref.watch(authProvider);
    final loginStatus = ref.watch(
      authProvider.select((value) => value.loginStatus),
    );
    final errorMessage = ref.watch(
      authProvider.select((value) => value.errorMessage),
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: loginStatus == LoginStatus.idle
            ? LoginForm()
            : loginStatus == LoginStatus.loading
                ? const CircularProgressIndicator()
                : loginStatus == LoginStatus.loginSuccess
                    ? const Text('Login Successful!')
                    : loginStatus == LoginStatus.loginFailed
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login Failed: $errorMessage'),
                              LoginForm(),
                            ],
                          )
                        : const SizedBox(),
      ),
    );
  }
}

class LoginForm extends ConsumerStatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _usernameController = TextEditingController(text: 'mor_2314');
  final _passwordController = TextEditingController(text: '83r5^_');

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          TextField(
            controller: _usernameController,
            decoration: const InputDecoration(labelText: 'Username'),
          ),
          TextField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              final username = _usernameController.text;
              final password = _passwordController.text;

              ref.read(authProvider.notifier).login(
                    username: username,
                    password: password,
                  );
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

enum LoginStatus {
  idle,
  loading,
  loginSuccess,
  loginFailed,
}

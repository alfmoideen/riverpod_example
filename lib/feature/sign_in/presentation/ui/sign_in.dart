// ignore_for_file: use_key_in_widget_constructors, library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:parking_app/core/dependencies/authentication/auth_provider.dart';
import 'package:parking_app/core/router/named_route.dart';
import 'package:parking_app/feature/sign_in/presentation/controller/auth_controller.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  @override
  Widget build(BuildContext context) {
    final loginStatus = ref.watch(
      authProvider.select((value) => value.loginStatus),
    );
    final errorMessage = ref.watch(
      authProvider.select((value) => value.errorMessage),
    );
    listenStateChange();
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Center(
        child: loginStatus == LoginStatus.idle
            ? LoginForm(
                mainRef: ref,
              )
            : loginStatus == LoginStatus.loading
                ? const CircularProgressIndicator()
                : loginStatus == LoginStatus.loginSuccess
                    ? const Text('Login Successful!')
                    : loginStatus == LoginStatus.loginFailed
                        ? Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('Login Failed: $errorMessage'),
                              LoginForm(mainRef: ref),
                            ],
                          )
                        : const SizedBox(),
      ),
    );
  }

  listenStateChange() {
    ref.listen<LoginStatus>(authProvider.select((value) => value.loginStatus),
        (prev, next) {
      if (next == LoginStatus.loginSuccess) {
        context.pushReplacementNamed(product);
      }
    });
  }
}

class LoginForm extends ConsumerStatefulWidget {
  final WidgetRef mainRef;
  const LoginForm({
    required this.mainRef,
  });
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
            onPressed: () async {
              final username = _usernameController.text;
              final password = _passwordController.text;

              await ref.read(authProvider.notifier).login(
                    username: username,
                    password: password,
                  );
              final newToken = widget.mainRef.read(authProvider).token;
              if (newToken.isNotEmpty) {
                updateAuthToken(newToken);
              }
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

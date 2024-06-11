import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parking_app/main.dart';

final authTokenProvider = StateProvider<String>((ref) {
  return "";
});

Future<void> updateAuthToken(String token,
    {bool shouldUpdateSession = true}) async {
  providerContainer.read(authTokenProvider.notifier).state = token;
}

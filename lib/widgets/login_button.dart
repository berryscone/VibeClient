import 'package:flutter/material.dart';
import 'package:vibe_client/services/google_auth_service.dart';

enum LoginType {
  google("Login with Google"),
  apple("Login with Apple");

  final String label;
  const LoginType(this.label);
}

class LoginButton extends StatelessWidget {
  final LoginType type;
  final double widthFactor;
  const LoginButton({super.key, required this.type, this.widthFactor = 0.7});

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: widthFactor,
      child: ElevatedButton(
        onPressed: () async {
          switch (type) {
            case LoginType.google:
              await GoogleAuthService().signInAndSendIdToken();
              break;
            case LoginType.apple:
              print(LoginType.apple.label);
              break;
          }
        },
        child: Text(type.label),
      ),
    );
  }
}

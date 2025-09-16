import 'dart:async';
import 'dart:convert';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;

class GoogleAuthService {
  static const List<String> scopes = <String>[
    "openid",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/userinfo.profile",
  ];
  static const String clientId =
      "820559692777-uegim4esplbirrddhtkcf50ekca4eiah.apps.googleusercontent.com";

  final GoogleSignIn signIn = GoogleSignIn.instance;

  Future<void> signInAndSendIdToken() async {
    signIn.initialize(clientId: clientId).then((_) {
      signIn.authenticationEvents
          .listen(_handleAuthenticationEvent)
          .onError(_handleAuthenticationError);

      signIn.authenticate();
    });
  }

  Future<void> _handleAuthenticationEvent(
    GoogleSignInAuthenticationEvent event,
  ) async {
    final GoogleSignInAccount? user = switch (event) {
      GoogleSignInAuthenticationEventSignIn() => event.user,
      GoogleSignInAuthenticationEventSignOut() => null,
    };

    final GoogleSignInClientAuthorization? authorization = await user
        ?.authorizationClient
        .authorizationForScopes(scopes);
  }

  Future<void> _handleAuthenticationError(Object e) async {}
}

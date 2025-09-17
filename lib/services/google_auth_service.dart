import 'dart:io';
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleAuthService {
  GoogleAuthService({
    GoogleSignIn? signIn,
    Future<void> Function(String idToken)? onIdToken,
  }) : _signIn = signIn ?? GoogleSignIn.instance,
       _onIdToken = onIdToken;

  static const List<String> scopes = <String>[
    "openid",
    "https://www.googleapis.com/auth/userinfo.email",
    "https://www.googleapis.com/auth/userinfo.profile",
  ];

  static const String clientIdAndroid =
      "820559692777-f3f2c8rda2avc1djn3lr0k2ab26t4dvt.apps.googleusercontent.com";
  static const String clientIdIos =
      "820559692777-1j0q54mk2p3jfvp66tuiqj3mlcg3p3pm.apps.googleusercontent.com";
  static const String clientIdWeb =
      "820559692777-rtmvklk906vtur03q5i354s54kqkerve.apps.googleusercontent.com";

  final GoogleSignIn _signIn;
  final Future<void> Function(String idToken)? _onIdToken;
  Future<void>? _initialization;

  Future<void> signInAndSendIdToken() async {
    await _ensureInitialized();

    final GoogleSignInAccount account = await _signIn.authenticate(
      scopeHint: scopes,
    );
    final String? idToken = account.authentication.idToken;
    if (idToken == null || idToken.isEmpty) {
      throw StateError('Google Sign-In did not return an ID token.');
    }

    await _sendIdToken(idToken);
  }

  Future<void> _ensureInitialized() {
    String clientId = clientIdAndroid;
    if (Platform.isAndroid) {
      clientId = clientIdAndroid;
    } else if (Platform.isIOS) {
      clientId = clientIdIos;
    }
    return _initialization ??= _signIn.initialize(
      clientId: clientId,
      serverClientId: clientIdWeb,
    );
  }

  Future<void> _sendIdToken(String idToken) async {
    if (_onIdToken != null) {
      await _onIdToken!(idToken);
      return;
    }

    debugPrint(
      'GoogleAuthService captured an ID token (${idToken.length} characters).',
    );
  }
}

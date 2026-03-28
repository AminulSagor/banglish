import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../models/auth_models.dart';

class AuthModuleService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<AuthUserUiModel?> login(LoginPayloadModel payload) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return AuthUserUiModel.fromJson({
      'uid': 'mock_${DateTime.now().millisecondsSinceEpoch}',
      'name': payload.email.split('@').first,
      'email': payload.email,
      'photoUrl': '',
      'isVerified': true,
      'country': '',
      'division': '',
      'district': '',
      'gender': 'Male',
    });
  }

  Future<AuthUserUiModel?> signup(SignupPayloadModel payload) async {
    await Future.delayed(const Duration(milliseconds: 300));

    return AuthUserUiModel.fromJson({
      'uid': 'mock_${DateTime.now().millisecondsSinceEpoch}',
      'name': payload.name,
      'email': payload.email,
      'photoUrl': '',
      'isVerified': false,
      'country': payload.country,
      'division': payload.division,
      'district': payload.district,
      'gender': payload.gender,
    });
  }

  Future<AuthUserUiModel?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _auth.signInWithCredential(credential);
    return _toAuthUiModel(userCredential.user);
  }

  Future<AuthUserUiModel?> signInWithFacebook() async {
    final LoginResult result = await FacebookAuth.instance.login(
      permissions: ['public_profile'],
    );

    if (result.status != LoginStatus.success) return null;

    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

    final userCredential = await _auth.signInWithCredential(
      facebookAuthCredential,
    );
    return _toAuthUiModel(userCredential.user);
  }

  Future<OtpUiModel> requestPasswordReset(
    ForgotPasswordPayloadModel payload,
  ) async {
    await Future.delayed(const Duration(milliseconds: 300));
    final otp = _generateOtp(5);
    return OtpUiModel.fromJson({'email': payload.email, 'otp': otp});
  }

  Future<void> signOut() async {
    await Future.wait([
      _auth.signOut(),
      _googleSignIn.signOut(),
      FacebookAuth.instance.logOut(),
    ]);
  }

  AuthUserUiModel _toAuthUiModel(User? user) {
    return AuthUserUiModel.fromJson({
      'uid': user?.uid ?? '',
      'name': user?.displayName ?? '',
      'email': user?.email ?? '',
      'photoUrl': user?.photoURL ?? '',
      'isVerified': user?.emailVerified ?? false,
      'country': '',
      'division': '',
      'district': '',
      'gender': '',
    });
  }

  String _generateOtp(int length) {
    final random = Random();
    return List.generate(length, (_) => random.nextInt(10)).join();
  }
}

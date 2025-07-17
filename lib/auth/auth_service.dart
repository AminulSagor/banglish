import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final GoogleSignInAuthentication googleAuth =
      await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final userCredential = await _auth.signInWithCredential(credential);
      final user = userCredential.user;

      if (user != null) {
        final userDoc = _firestore.collection('users').doc(user.uid);

        final exists = (await userDoc.get()).exists;

        if (!exists) {
          await userDoc.set({
            'uid': user.uid,
            'email': user.email,
            'name': user.displayName,
            'photoUrl': user.photoURL,
            'createdAt': FieldValue.serverTimestamp(),
            'lastLogin': FieldValue.serverTimestamp(),
          });
        } else {
          await userDoc.update({
            'lastLogin': FieldValue.serverTimestamp(),
          });
        }
      }

      return userCredential;
    } catch (e) {
      print("❌ Google Sign-In Error: $e");
      rethrow;
    }
  }



  Future<void> sendOTPEmail(String email, String otp) async {
    final smtpUsername = dotenv.env['SMTP_USER'] ?? '';
    final smtpPassword = dotenv.env['SMTP_PASS'] ?? '';

    final smtpServer = gmail(smtpUsername, smtpPassword);

    final message = Message()
      ..from = Address(smtpUsername, 'GardenAid')
      ..recipients.add(email)
      ..subject = 'Your GardenAid OTP Code'
      ..text = 'Your OTP code is: $otp';

    try {
      await send(message, smtpServer);
    } catch (e) {
      print('❌ Email send failed: $e');
      rethrow;
    }
  }



  Future<UserCredential?> signInWithFacebook() async {
    try {
      // Only request public_profile permission
      final LoginResult result = await FacebookAuth.instance.login(
        permissions: ['public_profile'],
      );

      if (result.status == LoginStatus.success) {
        final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);

        final userCredential =
        await _auth.signInWithCredential(facebookAuthCredential);

        final user = userCredential.user;

        if (user != null) {
          final userDoc = _firestore.collection('users').doc(user.uid);

          final exists = (await userDoc.get()).exists;

          if (!exists) {
            await userDoc.set({
              'uid': user.uid,
              'email': user.email ?? '', // ✅ Optional, fallback to empty
              'name': user.displayName ?? '',
              'photoUrl': user.photoURL ?? '',
              'createdAt': FieldValue.serverTimestamp(),
              'lastLogin': FieldValue.serverTimestamp(),
            });
          } else {
            await userDoc.update({
              'lastLogin': FieldValue.serverTimestamp(),
            });
          }
        }

        return userCredential;
      } else {
        throw Exception("Facebook login failed: ${result.status}");
      }
    } catch (e) {
      print("❌ Facebook Sign-In Error: $e");
      rethrow;
    }
  }


  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _auth.signOut();
  }

  User? get currentUser => _auth.currentUser;
}

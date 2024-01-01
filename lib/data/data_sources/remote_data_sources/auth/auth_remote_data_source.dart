import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../core/error/failures.dart';
import '../../../../di/dependency-injection.dart';
import '../../local_data_sources/pref_manger.dart';

class AuthRemoteDataSource {
  ///sign in with google
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential).timeout(
       const Duration(seconds: 30),onTimeout: (){
      throw(Exception('it took too long time to connect please check your connectivity and try again'));
    });
  }

  /// sign in with face book
  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult loginResult = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(loginResult.accessToken!.token);

    // Once signed in, return the UserCredential
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }

  /// update or add user data
  /// if user doc is exist it will update it
  /// else it will add it
  Future<void> updateOrAddUserCredentials(
      Map<String, dynamic> userCredentials) async {
    final userId = sl<FirebaseAuth>().currentUser!.uid;
    final userCheck = sl<FirebaseFirestore>().collection('users').doc(userId);
    try {
      userCheck.get().then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          userCheck.update(userCredentials);
        } else {
          userCheck.set(userCredentials);
        }
      });
    } catch (e) {
      UnStableInternetConnectionFailure();
    }
  }

  /// verifying user phone number first approach
  Future<String> verifyPhoneNumber({required String phoneNumber}) async {
    final completer = Completer<String>();
    await sl<FirebaseAuth>().verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (credentials) async {
          ///update  user phone number in fire store
          completer.complete('completed');
        },
        verificationFailed: (e) {
          String error = e.code == 'invalid-phone-number'
              ? "Invalid number. Enter again."
              : "Can Not Login Now. Please try again.";
          completer.complete(error);
        },
        codeSent: (verificationId, [tokenId]) {
          completer.complete("codeSent$verificationId");
        },
        timeout: const Duration(seconds: 60),
        codeAutoRetrievalTimeout: (timeOut) {
          completer.complete('timeOut');
        });
    return completer.future;
  }
/// verifying phone number second approach
  Future<void> verifyPhoneNumberTest({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required Duration timeout

  }) async {
    await sl<FirebaseAuth>().verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: verificationCompleted,
        verificationFailed:verificationFailed,
        codeSent:codeSent,
        timeout: timeout,
        codeAutoRetrievalTimeout:codeAutoRetrievalTimeout
    );
  }

  ///link verified phone with current user credentials
  Future<void> verifyOtpCode(
      {required String verificationId, required String smsCode}) async {
    final credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    try {
      final userDoc = sl<FirebaseFirestore>()
          .collection('users')
          .doc(sl<FirebaseAuth>().currentUser!.uid);
      await sl<FirebaseAuth>()
          .currentUser!
          .linkWithCredential(credential)
          .then((val) {
        userDoc.update({
          'phoneNumber': sl<FirebaseAuth>().currentUser!.phoneNumber ?? ''
        }).then((value) {
          userDoc.get().then((DocumentSnapshot documentSnapshot) {
            final userPrefData = json.encode(documentSnapshot.data());
            sl<PrefManger>().userCredentials = userPrefData;
          });
        });
      });
    } catch (e) {
      rethrow;
    }
  }
}

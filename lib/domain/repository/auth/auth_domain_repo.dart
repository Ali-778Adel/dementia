import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failures.dart';

abstract class AuthDomainRepo{
  Future<Either<Failure,UserCredential>>signInWithFacebook();
  Future<Either<Failure,UserCredential>>signInWithGoogle();
  Future<Either<Failure,bool>>postUserData(Map<String,dynamic>data);
  /// verfying phone number
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required Duration timeout
  });
  Future<Either<Failure,Unit>>linkPhoneNumber({required String smsCode,required String verificationId});

}
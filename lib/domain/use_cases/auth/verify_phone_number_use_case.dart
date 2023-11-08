import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_control/core/error/failures.dart';
import 'package:time_control/domain/repository/auth/auth_domain_repo.dart';

class VerifyPhoneNumberUseCase{
  final AuthDomainRepo authDomainRepo;
  VerifyPhoneNumberUseCase({required this.authDomainRepo});
  Future<void>call({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required Duration timeout})async{
    await authDomainRepo.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted:verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
        timeout: timeout);
  }

}
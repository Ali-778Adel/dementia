import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/error/failures.dart';

abstract class AuthDomainRepo{
  Future<Either<Failure,UserCredential>>signInWithFacebook();
  Future<Either<Failure,UserCredential>>signInWithGoogle();
  Future<Either<Failure,bool>>postUserData(Map<String,dynamic>data);
  Future<Either<Failure,String>>verifyPhoneNumber({required String phoneNumber});
  Future<Either<Failure,void>>linkPhoneNumber({required String smsCode,required String verificationId});

}
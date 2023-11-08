import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../di/dependency-injection.dart';
import '../../../core/error/failures.dart';
import '../../../domain/repository/auth/auth_domain_repo.dart';
import '../../../utils/services/internet_connection_checker.dart';
import '../../data_sources/local_data_sources/pref_manger.dart';
import '../../data_sources/remote_data_sources/auth/auth_remote_data_source.dart';
import '../../models/settings/user_model.dart';

class AuthDataRepo implements AuthDomainRepo{
  final NetworkInfo networkInfo;
  final AuthRemoteDataSource authRemoteDataSource;

  AuthDataRepo({required this.networkInfo,required this.authRemoteDataSource});

  @override
  Future<Either<Failure, UserCredential>> signInWithFacebook()async{
    if(await networkInfo.isConnected){
      final response=await authRemoteDataSource.signInWithFacebook();
      final responseToModel=fillUserModel(response);
      sl<PrefManger>().userCredentials=json.encode(responseToModel.toJson());
      await postUserData(responseToModel.toJson());
      return right(response);
    }else{
      return left(InternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure, UserCredential>> signInWithGoogle()async {
    if(await networkInfo.isConnected){
      final response=await authRemoteDataSource.signInWithGoogle();
      final responseToModel=fillUserModel(response);
      sl<PrefManger>().userCredentials=json.encode(responseToModel.toJson());
       await postUserData(responseToModel.toJson());
      return right(response);
    }else{
      return left(InternetConnectionFailure());
    }
  }


  UserModel fillUserModel(UserCredential response){
    return UserModel(
      email: response.user!.email,
      photoUrl: response.user!.photoURL,
      userName: response.user!.displayName,
      token: response.credential!.accessToken,
      accessToken:response.credential!.accessToken,
      phoneNumber: response.user!.phoneNumber,
    );
  }

  @override
  Future<Either<Failure,bool>> postUserData(Map<String,dynamic>data)async {
    if(await networkInfo.isConnected){
      await authRemoteDataSource.updateOrAddUserCredentials(data);
      return right(true);
    }else{
      return Left(InternetConnectionFailure());
    }
  }

  @override
  Future<Either<Failure,Unit>> linkPhoneNumber({required String smsCode, required String verificationId})async {
    if(await networkInfo.isConnected){
     await authRemoteDataSource.verifyOtpCode(verificationId: verificationId, smsCode: smsCode);
return right(unit);

    }else{
      return left(InternetConnectionFailure());
    }

  }

  @override
  Future<void> verifyPhoneNumber({
    required String phoneNumber,
    required void Function(PhoneAuthCredential) verificationCompleted,
    required void Function(FirebaseAuthException) verificationFailed,
    required void Function(String, int?) codeSent,
    required void Function(String) codeAutoRetrievalTimeout,
    required Duration timeout

  })async {
    if(await networkInfo.isConnected){
       await authRemoteDataSource.verifyPhoneNumberTest(
          phoneNumber: phoneNumber,
          verificationCompleted:verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
          timeout: timeout);
    }else{
      throw left(InternetConnectionFailure());
    }
  }


}
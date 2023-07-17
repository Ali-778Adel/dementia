import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:time_control/domain/repository/auth/auth_domain_repo.dart';

import '../../../core/error/failures.dart';

class SignInWithGoogleUseCase {
  AuthDomainRepo authDomainRepo;
  SignInWithGoogleUseCase({required this.authDomainRepo});

  Future<Either<Failure, UserCredential>> call()async {
    return await authDomainRepo.signInWithGoogle();
  }
}

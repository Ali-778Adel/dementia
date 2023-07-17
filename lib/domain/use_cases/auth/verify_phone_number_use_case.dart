import 'package:dartz/dartz.dart';
import 'package:time_control/core/error/failures.dart';
import 'package:time_control/domain/repository/auth/auth_domain_repo.dart';

class VerifyPhoneNumberUseCase{
  final AuthDomainRepo authDomainRepo;
  VerifyPhoneNumberUseCase({required this.authDomainRepo});
  Future<Either<Failure,String>>call({required String phoneNumber})async{
    return authDomainRepo.verifyPhoneNumber(phoneNumber: phoneNumber);
  }

}
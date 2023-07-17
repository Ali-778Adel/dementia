import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repository/auth/auth_domain_repo.dart';

class LinkWithPhoneNumberUseCase{
  final AuthDomainRepo authDomainRepo;
  LinkWithPhoneNumberUseCase({required this.authDomainRepo});

  Future<Either<Failure,void>>call({required String smsCode,required String verificationId})async{
    return authDomainRepo.linkPhoneNumber(smsCode: smsCode, verificationId: verificationId);
  }


}
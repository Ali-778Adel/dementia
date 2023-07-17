import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../repository/auth/auth_domain_repo.dart';

class PostUserDataUseCase{
  final AuthDomainRepo authDomainRepo;
  PostUserDataUseCase({required this.authDomainRepo});

  Future<Either<Failure,bool>>call(Map<String,dynamic>data){
    return authDomainRepo.postUserData(data);
  }

}
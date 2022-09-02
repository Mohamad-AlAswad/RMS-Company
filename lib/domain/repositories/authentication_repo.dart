import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/entities.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/user/user_info.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, void>> signUpEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> signInEmailAndPassword({
    required String email,
    required String password,
  });

  Future<Either<Failure, void>> logOut();

  String? get userId;

  String? get companyId;

  UserInfo? get connectedUser;

  Company get connectedCompany;
}

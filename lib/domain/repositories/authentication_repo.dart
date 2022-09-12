import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/entities.dart';

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

  UserInfo? get connectedUser;

  List<String> get companies;

  String? get connectedCompany;

  Company? get connectedCompanyInstance;

  set connectedCompany(String? company);
}

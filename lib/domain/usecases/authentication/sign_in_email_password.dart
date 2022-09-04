import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../injection_container.dart';
import '../../repositories/authentication_repo.dart';

class SignInEmailAndPassword {
  final AuthenticationRepo authenticationRepo;

  SignInEmailAndPassword() : authenticationRepo = sl();

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return  authenticationRepo.signInEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

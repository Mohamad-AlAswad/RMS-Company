import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../injection_container.dart';
import '../../repositories/authentication_repo.dart';

class SignUpEmailPassword {
  final AuthenticationRepo authenticationRepo;

  SignUpEmailPassword() : authenticationRepo = sl();

  Future<Either<Failure, void>> call({
    required String email,
    required String password,
  }) async {
    return await authenticationRepo.signUpEmailAndPassword(
      email: email,
      password: password,
    );
  }
}

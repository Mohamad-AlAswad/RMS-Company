import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../injection_container.dart';
import '../../repositories/authentication_repo.dart';

class LogOut {
  final AuthenticationRepo authenticationRepo;

  LogOut() : authenticationRepo = sl();

  Future<Either<Failure, void>> call() async {
    return await authenticationRepo.logOut();
  }
}

import '../../repositories/authentication_repo.dart';
import '../../entities/user/user_info.dart' as user_ent;

class ConnectedCompanyUser {
  final AuthenticationRepo authenticationRepo;

  ConnectedCompanyUser(this.authenticationRepo);

  String? get companyId => authenticationRepo.userId;

  user_ent.UserInfo? get connectedUser => authenticationRepo.connectedUser;
}

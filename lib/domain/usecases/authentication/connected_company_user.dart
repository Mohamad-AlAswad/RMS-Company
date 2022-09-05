import '../../../injection_container.dart';
import '../../entities/user/user_info.dart' as user_ent;
import '../../repositories/authentication_repo.dart';

class ConnectedCompanyUser {
  final AuthenticationRepo authenticationRepo;

  ConnectedCompanyUser() : authenticationRepo = sl();

  String? get companyId => authenticationRepo.userId;
  List<String>? get companyIds => [authenticationRepo.userId!];

  user_ent.UserInfo? get connectedUser => authenticationRepo.connectedUser;
}

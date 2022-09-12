import '../../../injection_container.dart';
import '../../entities/company.dart';
import '../../entities/user/user_info.dart' as user_ent;
import '../../repositories/authentication_repo.dart';

class GetConnectedUser {
  final AuthenticationRepo authenticationRepo;

  GetConnectedUser() : authenticationRepo = sl();

  String? get userId => authenticationRepo.userId;

  user_ent.UserInfo? get connectedUser => authenticationRepo.connectedUser;

  List<String> get companies => authenticationRepo.companies;

  String? get connectedCompany => authenticationRepo.connectedCompany;

  Company? get connectedCompanyInstance =>
      authenticationRepo.connectedCompanyInstance;

  set connectedCompany(String? company) =>
      authenticationRepo.connectedCompany = company;
}

import '../../../injection_container.dart';
import '../../repositories/company_repo.dart';

class RegisterCompany {
  final CompanyRepo companyRepo;

  RegisterCompany() : companyRepo = sl();

  Future<bool> call({required String company}) =>
      companyRepo.registerCompany(company: company);
}

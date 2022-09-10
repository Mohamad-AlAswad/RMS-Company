import '../../../injection_container.dart';
import '../../repositories/company_repo.dart';

class CheckCompany {
  final CompanyRepo companyRepo;

  CheckCompany() : companyRepo = sl();

  Future<bool> call({required String company}) =>
      companyRepo.checkCompany(company: company);
}

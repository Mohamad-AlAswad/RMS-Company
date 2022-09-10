import '../../../injection_container.dart';
import '../../entities/company.dart';
import '../../repositories/company_repo.dart';

class UpdateCompany {
  final CompanyRepo companyRepo;

  UpdateCompany() : companyRepo = sl();

  Future<List<String>> call({required Company newCompany}) =>
      companyRepo.updateCompany(newCompany: newCompany);
}

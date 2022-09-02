import 'package:rms_company/domain/repositories/job/applied_repo.dart';

import '../../../../injection_container.dart';
import '../../../entities/job/evaluated/full_evaluated_job.dart';

class GetDetailedApplied {
  final AppliedRepo appliedRepo;

  GetDetailedApplied() : appliedRepo = sl();

  Future<FullEvaluatedJob> call({required String id}) async {
    FullEvaluatedJob? result;
    (await appliedRepo.detailed(id: id)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result!;
  }
}

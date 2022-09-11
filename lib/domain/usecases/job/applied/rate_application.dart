import 'package:rms_company/domain/entities/job/applied/applied_job.dart';

import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../repositories/job/applied_repo.dart';

class RateApplication {
  final AppliedRepo appliedRepo;

  RateApplication()
      : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          jobId: '',
          userInfoRepo: sl(),
        );

  Future<List<String>> call({
    required AppliedJob appliedJob,
    required num rating,
  }) async {
    return (await appliedRepo.rateApplication(
      appliedJob: appliedJob,
      rating: rating,
    ))
        .map((e) => e.message)
        .toList();
  }
}

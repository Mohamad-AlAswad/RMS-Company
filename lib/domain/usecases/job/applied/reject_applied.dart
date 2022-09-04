import 'package:rms_company/domain/repositories/job/applied_repo.dart';

import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';

class RejectApplied {
  final AppliedRepo appliedRepo;

  RejectApplied({
    required String jobId,
  }) : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          jobId: jobId,
        );

  Future<List<String>> call({required String appliedId}) async {
    return (await appliedRepo.reject(appliedId: appliedId))
        .map((e) => e.message)
        .toList();
  }
}

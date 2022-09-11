import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../entities/job/applied/full_applied_job.dart';
import '../../../repositories/job/applied_repo.dart';

class GetDetailedApplied {
  final AppliedRepo appliedRepo;

  GetDetailedApplied({
    required String jobId,
  }) : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          jobId: jobId,
          userInfoRepo: sl(),
        );

  Future<FullAppliedJob> call({required String id}) async {
    FullAppliedJob? result;
    (await appliedRepo.detailed(id: id)).fold(
      (failure) => result = null,
      (data) => result = data,
    );
    return result!;
  }
}

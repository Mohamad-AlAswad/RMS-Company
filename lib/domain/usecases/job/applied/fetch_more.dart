import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../entities/job/applied/applied_job.dart';
import '../../../entities/job/applied/job_application_states.dart';
import '../../../repositories/job/applied_repo.dart';

class FetchMoreApplied {
  final AppliedRepo appliedRepo;

  FetchMoreApplied({
    required String jobId,
    ApplicationStates? applicationStates,
  }) : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          jobId: jobId,
          applicationStates: applicationStates,
        );

  Future<List<AppliedJob>> call({required int limit}) async {
    List<AppliedJob> result = [];
    (await appliedRepo.fetch(limit: limit)).fold(
      (failure) => result = [],
      (data) => result = data,
    );
    return result;
  }

  void refresh() => appliedRepo.refresh();
}

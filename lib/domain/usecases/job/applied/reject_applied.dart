import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../repositories/job/applied_repo.dart';

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

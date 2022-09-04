import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../repositories/job/applied_repo.dart';

class RateApplication {
  final AppliedRepo appliedRepo;

  RateApplication()
      : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          jobId: '',
        );

  Future<List<String>> call({
    required String appliedJobId,
    required num rating,
  }) async {
    return (await appliedRepo.rateApplication(
      appliedJobId: appliedJobId,
      rating: rating,
    ))
        .map((e) => e.message)
        .toList();
  }
}

import '../../../../injection_container.dart';
import '../../../entities/job/full_evaluated_job.dart';
import '../../../repositories/job/unavailable_repo.dart';

class GetDetailedUnavailable {
  final UnavailableRepo unavailableRepo;

  GetDetailedUnavailable() : unavailableRepo = sl();

  Future<FullEvaluatedJob> call({required String id}) async {
    FullEvaluatedJob? result;
    (await unavailableRepo.detailed(id: id)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result!;
  }
}

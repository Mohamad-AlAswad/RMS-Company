import '../../../injection_container.dart';
import '../../repositories/job/job_repo.dart';

class RemoveJob {
  final JobRepo jobRepo;

  RemoveJob() : jobRepo = sl();

  Future<List<String>> call({required String jobId}) async {
    return (await jobRepo.remove(jobId: jobId)).map((e) => e.message).toList();
  }
}

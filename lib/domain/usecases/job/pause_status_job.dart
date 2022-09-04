import '../../../injection_container.dart';
import '../../repositories/job/job_repo.dart';

class PauseStatusJob {
  final JobRepo jobRepo;

  PauseStatusJob() : jobRepo = sl();

  Future<List<String>> call({required String jobId}) async {
    return (await jobRepo.pause(jobId: jobId)).map((e) => e.message).toList();
  }
}

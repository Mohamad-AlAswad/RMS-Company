import '../../../injection_container.dart';
import '../../repositories/job/job_repo.dart';

class ResumeStatusJob {
  final JobRepo jobRepo;

  ResumeStatusJob() : jobRepo = sl();

  Future<List<String>> call({required String jobId}) async {
    return (await jobRepo.resume(jobId: jobId)).map((e) => e.message).toList();
  }
}

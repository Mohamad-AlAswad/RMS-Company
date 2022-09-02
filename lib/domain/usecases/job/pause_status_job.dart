import '../../repositories/job/job_repo.dart';

class PauseJob {
  final JobRepo jobRepo;

  PauseJob({required this.jobRepo});

  Future<List<String>> call({required String jobId}) async {
    return (await jobRepo.pause(jobId: jobId)).map((e) => e.message).toList();
  }
}

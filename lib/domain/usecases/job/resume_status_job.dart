import '../../repositories/job/job_repo.dart';

class ResumeJob {
  final JobRepo jobRepo;

  ResumeJob({required this.jobRepo});

  Future<List<String>> call({required String jobId}) async {
    return (await jobRepo.resume(jobId: jobId)).map((e) => e.message).toList();
  }
}

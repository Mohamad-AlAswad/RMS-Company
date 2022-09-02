import '../../repositories/job/job_repo.dart';

class RemoveJob {
  final JobRepo jobRepo;

  RemoveJob({required this.jobRepo});

  Future<List<String>> call({required String jobId}) async {
    return (await jobRepo.remove(jobId: jobId)).map((e) => e.message).toList();
  }
}

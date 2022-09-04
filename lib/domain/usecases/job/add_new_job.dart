import '../../../injection_container.dart';
import '../../entities/job/job.dart';
import '../../repositories/job/job_repo.dart';

class AddNewJob {
  final JobRepo jobRepo;

  AddNewJob() : jobRepo = sl();

  Future<List<String>> call({required Job job}) async {
    return (await jobRepo.add(job: job)).map((e) => e.message).toList();
  }
}

import 'package:rms_company/domain/entities/job/job.dart';
import 'package:rms_company/domain/repositories/job/job_repo.dart';

import '../../../injection_container.dart';

class AddNewJob {
  final JobRepo jobRepo;

  AddNewJob() : jobRepo = sl();

  Future<List<String>> call({required Job job}) async {
    return (await jobRepo.add(job: job)).map((e) => e.message).toList();
  }
}

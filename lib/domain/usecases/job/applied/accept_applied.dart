import 'package:rms_company/domain/entities/job/applied/applied_job.dart';
import 'package:rms_company/domain/entities/job/applied/job_application_states.dart';

import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../repositories/job/applied_repo.dart';

class AcceptApplied {
  final AppliedRepo appliedRepo;

  AcceptApplied({
    required String jobId,
  }) : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          jobId: jobId,
        );

  Future<List<String>> call({required AppliedJob appliedJob}) async {
    return (await appliedRepo.accept(
      appliedId: appliedJob.appliedId,
      nextState: _getNext(appliedJob.state),
    ))
        .map((e) => e.message)
        .toList();
  }

  ApplicationStates _getNext(String state) {
    if (state == 'screening') return ApplicationStates.reviewing;
    if (state == 'reviewing') return ApplicationStates.interviewing;
    if (state == 'interviewing') return ApplicationStates.hired;
    return ApplicationStates.rejected;
  }
}

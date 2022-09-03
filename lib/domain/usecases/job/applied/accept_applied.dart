import 'package:rms_company/domain/entities/job/applied/applied_job.dart';
import 'package:rms_company/domain/entities/job/applied/job_application_states.dart';

import '../../../repositories/job/applied_repo.dart';

class AcceptApplied {
  final AppliedRepo appliedRepo;

  AcceptApplied({required this.appliedRepo});

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

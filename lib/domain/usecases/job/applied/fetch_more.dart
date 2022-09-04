import 'package:rms_company/data/repositories/job/applied_repo_imp.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';
import 'package:rms_company/domain/repositories/job/applied_repo.dart';

import '../../../../injection_container.dart';

class FetchMoreApplied {
  final AppliedRepo appliedRepo;

  FetchMoreApplied({required String jobId})
      : appliedRepo = AppliedRepoImp(firebaseFirestore: sl(), jobId: jobId);

  Future<List<AppliedJob>> call({required int limit}) async {
    List<AppliedJob> result = [];
    (await appliedRepo.fetch(limit: limit)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result;
  }

  void refresh() => appliedRepo.refresh();
}

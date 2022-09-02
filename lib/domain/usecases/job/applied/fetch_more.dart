import 'package:rms_company/domain/repositories/job/applied_repo.dart';

import '../../../../injection_container.dart';
import '../../../entities/job/evaluated/evaluated_job.dart';

class FetchMoreApplied {
  final AppliedRepo appliedRepo;

  FetchMoreApplied() : appliedRepo = sl();

  Future<List<EvaluatedJob>> call({required int limit}) async {
    List<EvaluatedJob> result = [];
    (await appliedRepo.fetch(limit: limit)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result;
  }

  void refresh() => appliedRepo.refresh();
}

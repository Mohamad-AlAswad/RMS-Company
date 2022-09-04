import 'package:rms_company/domain/repositories/job/applied_repo.dart';

import '../../../../injection_container.dart';

class RejectApplied {
  final AppliedRepo appliedRepo;

  RejectApplied() : appliedRepo = sl();

  Future<List<String>> call({required String appliedId}) async {
    return (await appliedRepo.reject(appliedId: appliedId))
        .map((e) => e.message)
        .toList();
  }
}

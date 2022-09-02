import 'package:rms_company/domain/repositories/job/applied_repo.dart';

class RejectApplied {
  final AppliedRepo appliedRepo;

  RejectApplied({required this.appliedRepo});

  Future<List<String>> call({required String appliedId}) async {
    return (await appliedRepo.reject(appliedId: appliedId))
        .map((e) => e.message)
        .toList();
  }
}

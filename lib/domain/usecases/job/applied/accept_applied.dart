import '../../../repositories/job/applied_repo.dart';

class AcceptApplied {
  final AppliedRepo appliedRepo;

  AcceptApplied({required this.appliedRepo});

  Future<List<String>> call({required String appliedId}) async {
    return (await appliedRepo.accept(appliedId: appliedId))
        .map((e) => e.message)
        .toList();
  }
}

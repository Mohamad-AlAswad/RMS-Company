import '../../../../data/repositories/job/applied_repo_imp.dart';
import '../../../../injection_container.dart';
import '../../../entities/job/applied/applied_job.dart';
import '../../../repositories/job/applied_repo.dart';

class AddNote {
  final AppliedRepo appliedRepo;

  AddNote()
      : appliedRepo = AppliedRepoImp(
          firebaseFirestore: sl(),
          jobId: '',
          userInfoRepo: sl(),
        );

  Future<List<String>> call({
    required AppliedJob appliedJob,
    required String note,
  }) async =>
      (await appliedRepo.addNote(appliedJob: appliedJob, note: note))
          .map((e) => e.message)
          .toList();
}

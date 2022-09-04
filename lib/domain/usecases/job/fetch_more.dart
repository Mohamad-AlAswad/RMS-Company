import '../../../../injection_container.dart';
import '../../entities/entities.dart';
import '../../repositories/job/job_repo.dart';

class FetchMoreJob {
  final JobRepo jobRepo;

  FetchMoreJob() : jobRepo = sl();

  Future<List<Job>> call({required int limit}) async {
    List<Job> result = [];
    (await jobRepo.fetch(limit: limit)).fold(
      (failure) => result = [],
      (data) => result = data,
    );
    return result;
  }

  void refresh() => jobRepo.refresh();

  bool get noMoreData => jobRepo.noMoreData;
}

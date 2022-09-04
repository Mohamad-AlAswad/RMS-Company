import 'package:rms_company/data/repositories/job/job_repo_imp.dart';
import 'package:rms_company/domain/entities/entities.dart';
import 'package:rms_company/domain/repositories/job/job_repo.dart';

import '../../../../injection_container.dart';

class FetchMoreJob {
  final JobRepo jobRepo;

  FetchMoreJob() : jobRepo = sl();

  Future<List<Job>> call({required int limit}) async {
    List<Job> result = [];
    print('????');
    (await jobRepo.fetch(limit: limit)).fold(
      (failure) => print(failure.message),
      (data) => result = data,
    );
    return result;
  }

  void refresh() => jobRepo.refresh();

  bool get noMoreData => jobRepo.noMoreData;
}

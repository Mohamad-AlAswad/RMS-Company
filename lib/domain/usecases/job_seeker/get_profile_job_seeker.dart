import '../../../injection_container.dart';
import '../../entities/job_seeker/job_seeker_info.dart';
import '../../repositories/job_seeker_info_repo.dart';

class GetProfileJobSeeker {
  final JobSeekerInfoRepo jobSeekerInfoRepo;

  GetProfileJobSeeker() : jobSeekerInfoRepo = sl();

  Future<JobSeekerInfo?> call({required String userId}) async {
    // String userId = GetConnectedUser(sl()).userId!;
    JobSeekerInfo? result;
    (await jobSeekerInfoRepo.getJobSeekerInfo(userId: userId)).fold(
      (failure) => result = null,
      (data) => result = data,
    );
    return result;
  }
}

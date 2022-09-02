import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/job_seeker/job_seeker_info.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/user/user_info.dart';

abstract class JobSeekerInfoRepo {
  Future<Either<Failure, JobSeekerInfo>> getJobSeekerInfo(
      {required String userId});
}

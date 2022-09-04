import 'package:dartz/dartz.dart';

import '../../core/errors/failures/failure.dart';
import '../entities/job_seeker/job_seeker_info.dart';

abstract class JobSeekerInfoRepo {
  Future<Either<Failure, JobSeekerInfo>> getJobSeekerInfo(
      {required String userId});
}

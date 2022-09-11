import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/applied/applied_job.dart';
import '../../entities/job/applied/full_applied_job.dart';
import '../../entities/job/applied/job_application_states.dart';

abstract class AppliedRepo {
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit});

  Future<Either<Failure, FullAppliedJob>> detailed({required String id});

  Future<List<Failure>> reject({required String appliedId});

  Future<List<Failure>> accept({
    required String appliedId,
    required ApplicationStates nextState,
  });

  Future<List<Failure>> rateApplication({
    required AppliedJob appliedJob,
    required num rating,
  });

  void refresh();

  bool get noMoreData;
}

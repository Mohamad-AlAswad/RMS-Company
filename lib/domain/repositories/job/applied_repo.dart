import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/job/evaluated/evaluated_job.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/job/evaluated/full_evaluated_job.dart';

abstract class AppliedRepo {
  Future<Either<Failure, List<EvaluatedJob>>> fetch({required int limit});

  Future<Either<Failure, FullEvaluatedJob>> detailed({required String id});

  Future<List<Failure>> reject({required String appliedId});

  Future<List<Failure>> accept({required String appliedId});

  void refresh();
}

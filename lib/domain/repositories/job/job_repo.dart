import 'package:dartz/dartz.dart';

import '../../../core/errors/failures/failure.dart';
import '../../entities/entities.dart';

abstract class JobRepo {
  Future<List<Failure>> add({required Job job});

  Future<List<Failure>> remove({required String jobId});

  Future<List<Failure>> pause({required String jobId});

  Future<List<Failure>> resume({required String jobId});

  Future<Either<Failure, List<Job>>> fetch({required int limit});

  void refresh();

  bool get noMoreData;
}

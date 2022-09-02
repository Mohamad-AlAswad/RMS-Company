import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/job/job.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/repositories/job/job_repo.dart';

class JobRepoImp implements JobRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;

  JobRepoImp({
    required this.firebaseFirestore,
    required String userId,
  }) : collection = firebaseFirestore.collection('jobs');

  @override
  Future<List<Failure>> add({required Job job}) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<List<Failure>> pause({required String jobId}) {
    // TODO: implement pause
    throw UnimplementedError();
  }

  @override
  Future<List<Failure>> remove({required String jobId}) {
    // TODO: implement remove
    throw UnimplementedError();
  }

  @override
  Future<List<Failure>> resume({required String jobId}) {
    // TODO: implement resume
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<Job>>> fetch({required int limit}) async {
    return Future.value(const Left(Unexpected()));
  }

  @override
  void refresh() {
    // TODO: implement refresh
  }
}

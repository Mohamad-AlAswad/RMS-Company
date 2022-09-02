import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/job/job.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/repositories/authentication_repo.dart';
import '../../../domain/repositories/job/job_repo.dart';
import '../../models/job/job_model.dart';

class JobRepoImp implements JobRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final AuthenticationRepo authenticationRepo;
  final Query query;

  JobRepoImp({
    required this.firebaseFirestore,
    required this.authenticationRepo,
  })  : collection = firebaseFirestore.collection('jobs'),
        query = firebaseFirestore
            .collection('jobs')
            .where('company-name', isEqualTo: authenticationRepo.companyName);

  @override
  Future<List<Failure>> add({required Job job}) async {
    print((await collection.add(JobModel.toSnapshot(
      companyName: authenticationRepo.companyName!,
      job: job,
    )))
        .id);

    return Future<List<Failure>>.value([]);
  }

  @override
  Future<List<Failure>> pause({required String jobId}) {
    // TODO: implement pause
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<List<Failure>> remove({required String jobId}) {
    // TODO: implement remove
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<List<Failure>> resume({required String jobId}) {
    // TODO: implement resume
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<Either<Failure, List<Job>>> fetch({required int limit}) async {
    // TODO: implement fetch
    return Future.value(const Left(Unexpected()));
  }

  @override
  void refresh() {
    // TODO: implement refresh
  }
}

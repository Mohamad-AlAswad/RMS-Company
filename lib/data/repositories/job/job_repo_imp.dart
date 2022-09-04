import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/job/job.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/repositories/authentication_repo.dart';
import '../../../domain/repositories/job/job_repo.dart';
import '../../../injection_container.dart';
import '../../models/job/job_model.dart';
import '../paginater_firestore.dart';

class JobRepoImp implements JobRepo {
  final FirebaseFirestore firebaseFirestore;
  late final CollectionReference<Map<String, dynamic>> collection;
  final AuthenticationRepo authenticationRepo;
  late final PaginaterFirestore paginaterFirestore;

  JobRepoImp()
      : firebaseFirestore = sl(),
        authenticationRepo = sl() {
    collection = firebaseFirestore.collection('jobs');
    paginaterFirestore = PaginaterFirestore(
      query: firebaseFirestore
          .collection('jobs')
          .where(
            'company-name',
            isEqualTo: authenticationRepo.companyName,
          )
          .orderBy('published-time'),
    );
    print(authenticationRepo.companyName);
  }

  @override
  Future<List<Failure>> add({required Job job}) async {
    await collection.add(
      JobModel.toSnapshot(
        companyName: authenticationRepo.companyName!,
        job: job,
      ),
    );
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<List<Failure>> pause({required String jobId}) {
    try {
      collection.doc(jobId).update({'status': 'paused'});
    } catch (e) {
      print(e);
    }
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<List<Failure>> resume({required String jobId}) {
    try {
      collection.doc(jobId).update({'status': 'running'});
    } catch (e) {
      print(e);
    }
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<List<Failure>> remove({required String jobId}) {
    try {
      collection.doc(jobId).delete();
    } catch (e) {
      print(e);
    }
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<Either<Failure, List<Job>>> fetch({required int limit}) async {
    try {
      var response = await paginaterFirestore.fetch(limit: limit);
      var result = response!.docs
          .map((e) => JobModel.fromSnapshot(
                id: e.id,
                documentSnapshot: e.data() as Map<String, dynamic>,
              )!)
          .toList();
      paginaterFirestore.commitFetching();
      return Future.value(Right(result));
    } catch (e) {
      print(e);
      return Future.value(const Left(Unexpected()));
    }
  }

  @override
  void refresh() => paginaterFirestore.refresh();

  @override
  bool get noMoreData => paginaterFirestore.noMoreData;
}

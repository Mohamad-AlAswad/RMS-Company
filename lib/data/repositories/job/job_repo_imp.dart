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
  bool lazy = true;
  bool _noMoreData = false;
  QueryDocumentSnapshot? last;

  JobRepoImp({
    required this.firebaseFirestore,
    required this.authenticationRepo,
  })  : collection = firebaseFirestore.collection('jobs'),
        query = firebaseFirestore.collection('jobs');

  // .where('company-name', isEqualTo: authenticationRepo.companyName)
  // .orderBy('publish-time');

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
    if (noMoreData == true) return Future.value(const Right([]));
    if (lazy == true) {
      last = null;
      _noMoreData = false;
    }
    lazy = false;
    print(last?.id);
    try {
      Query pagQuery = query.limit(limit);
      if (last != null) pagQuery = pagQuery.startAfterDocument(last!);
      var response = await pagQuery.get();
      if (response.docs.length < limit) {
        _noMoreData = true;
        last = null;
      } else {
        last = response.docs[response.docs.length - 1];
      }
      return Future.value(Right(response.docs
          .map((e) => JobModel.fromSnapshot(
                id: e.id,
                documentSnapshot: e.data() as Map<String, dynamic>,
              )!)
          .toList()));
    } catch (e) {
      print(e);
      return Future.value(const Left(Unexpected()));
    }
  }

  @override
  void refresh() => lazy = true;

  @override
  bool get noMoreData => _noMoreData;
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/data/models/job/inquiry_job_model.dart';
import 'package:rms_company/domain/entities/job/inquiry_job.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/job.dart';
import '../../../domain/repositories/authentication_repo.dart';
import '../../../domain/repositories/job/job_repo.dart';
import '../../../injection_container.dart';
import '../../models/job/job_model.dart';
import '../paginater_firestore.dart';

class JobRepoImp implements JobRepo {
  final FirebaseFirestore firebaseFirestore;
  late final CollectionReference<Map<String, dynamic>> collection;
  late final CollectionReference<Map<String, dynamic>> collection2;
  final AuthenticationRepo authenticationRepo;
  late final PaginaterFirestore paginaterFirestore;

  JobRepoImp()
      : firebaseFirestore = sl(),
        authenticationRepo = sl() {
    print(authenticationRepo.connectedCompany);
    collection = firebaseFirestore.collection('jobs');
    collection2 = firebaseFirestore.collection('jobs-applications');
    paginaterFirestore = PaginaterFirestore(
      query: firebaseFirestore
          .collection('jobs')
          .where(
            'company-name',
            isEqualTo: authenticationRepo.connectedCompany,
          )
          .orderBy('published-time'),
    );
  }

  @override
  Future<List<Failure>> add({required Job job}) async {
    await collection.add(
      JobModel.toSnapshot(
        companyName: authenticationRepo.connectedCompany!,
        job: job,
      ),
    );
    return Future<List<Failure>>.value([]);
  }

  @override
  Future<List<Failure>> pause({required String jobId}) {
    try {
      collection.doc(jobId).update({'status': 'paused'});
      return Future<List<Failure>>.value([]);
    } catch (e) {
      return Future<List<Failure>>.value([]);
    }
  }

  @override
  Future<List<Failure>> resume({required String jobId}) {
    try {
      collection.doc(jobId).update({'status': 'running'});
      return Future<List<Failure>>.value([]);
    } catch (e) {
      return Future<List<Failure>>.value([]);
    }
  }

  @override
  Future<List<Failure>> remove({required String jobId}) {
    try {
      collection.doc(jobId).delete();
      return Future<List<Failure>>.value([]);
    } catch (e) {
      return Future<List<Failure>>.value([]);
    }
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
      return Future.value(const Left(Unexpected()));
    }
  }

  @override
  void refresh() => paginaterFirestore.refresh();

  @override
  bool get noMoreData => paginaterFirestore.noMoreData;

  @override
  Future<List<Failure>> replyInquiry({
    required Job job,
    required InquiryJob inquiryJob,
    required String answer,
  }) async {
    List<InquiryJob> inquiries = [
      InquiryJob(
        inquiry: inquiryJob.inquiry,
        name: inquiryJob.name,
        inquiryDate: inquiryJob.inquiryDate,
        answer: answer,
        answerDate: Timestamp.now(),
      ),
    ];

    inquiries.addAll(
      job.inquiries.where((element) => element != inquiryJob).toList(),
    );
    var snap = InquiryJobModel.toSnapshot(inquiries);
    await collection.doc(job.id).update({'inquiries': snap});
    var docs = await collection2.where('job-id', isEqualTo: job.id).get();
    for (var doc in docs.docs) {
      await collection2.doc(doc.id).update({'inquiries': snap});
    }
    return [];
  }
}

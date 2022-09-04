import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/data/models/job_seeker/job_seeker_info_model.dart';
import 'package:rms_company/domain/entities/job_seeker/job_seeker_info.dart';

import '../../core/errors/failures/failure.dart';
import '../../domain/repositories/job_seeker_info_repo.dart';
import '../../injection_container.dart';

class JobSeekerInfoRepoImp implements JobSeekerInfoRepo {
  final FirebaseFirestore firebaseFirestore;
  late final CollectionReference<Map<String, dynamic>> collection;

  JobSeekerInfoRepoImp() : firebaseFirestore = sl() {
    collection = firebaseFirestore.collection('user-info');
  }

  @override
  Future<Either<Failure, JobSeekerInfo>> getJobSeekerInfo(
      {required String userId}) async {
    try {
      return Future.value(Right(JobSeekerInfoModel.fromSnapshot(
          documentSnapshot: (await collection.doc(userId).get()).data())!));
    } catch (e) {
      print('dasda WTF !!');
      print(e.toString());
      return Future.value(const Left(Unexpected(message: 'unexpected')));
    }
  }
}

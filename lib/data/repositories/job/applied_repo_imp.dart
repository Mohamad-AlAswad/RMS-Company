import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';
import 'package:rms_company/domain/entities/job/applied/full_applied_job.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/repositories/job/applied_repo.dart';

class AppliedRepoImp implements AppliedRepo {
  final FirebaseFirestore firebaseFirestore;

  AppliedRepoImp({required this.firebaseFirestore});

  @override
  Future<List<Failure>> accept({required String appliedId}) {
    // TODO: implement accept
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, FullAppliedJob>> detailed({required String id}) {
    // TODO: implement detailed
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit}) {
    // TODO: implement fetch
    throw UnimplementedError();
  }

  @override
  void refresh() {
    // TODO: implement refresh
  }

  @override
  Future<List<Failure>> reject({required String appliedId}) {
    // TODO: implement reject
    throw UnimplementedError();
  }
}

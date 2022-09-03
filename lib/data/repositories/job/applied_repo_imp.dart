import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/data/models/job/full_applied_job_model.dart';
import 'package:rms_company/data/models/job/job_application_states_model.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';
import 'package:rms_company/domain/entities/job/applied/full_applied_job.dart';
import 'package:rms_company/domain/entities/job/applied/job_application_states.dart';
import '../../../core/errors/failures/failure.dart';
import '../../../domain/repositories/job/applied_repo.dart';
import '../../models/job/applied_job_model.dart';
import '../paginater_firestore.dart';

class AppliedRepoImp implements AppliedRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final PaginaterFirestore paginaterFirestore;

  AppliedRepoImp({required this.firebaseFirestore, required String jobId})
      : collection = firebaseFirestore.collection('jobs-applications'),
        paginaterFirestore = PaginaterFirestore(
          query: firebaseFirestore
              .collection('jobs-applications')
              .where('job-id', isEqualTo: jobId),
        );

  @override
  Future<Either<Failure, FullAppliedJob>> detailed({required String id}) async {
    try {
      return Future.value(
        Right(
          FullAppliedJobModel.fromSnapshot(
            id: id,
            documentSnapshot: (await collection.doc(id).get()).data(),
          )!,
        ),
      );
    } catch (e) {
      print(e);
      return Future.value(const Left(Unexpected()));
    }
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit}) async {
    try {
      var response = await paginaterFirestore.fetch(limit: limit);
      return Future.value(Right(
        response!.docs
            .map((e) => AppliedJobModel.fromSnapshot(
                  id: e.id,
                  documentSnapshot: e.data() as Map<String, dynamic>,
                )!)
            .toList(),
      ));
    } catch (e) {
      print(e);
      return Future.value(const Left(Unexpected()));
    }
  }

  @override
  Future<List<Failure>> accept({
    required String appliedId,
    required ApplicationStates nextState,
  }) =>
      _changeState(appliedId: appliedId, nextState: nextState);

  @override
  Future<List<Failure>> reject({required String appliedId}) =>
      _changeState(appliedId: appliedId, nextState: ApplicationStates.rejected);

  Future<List<Failure>> _changeState({
    required String appliedId,
    required ApplicationStates nextState,
  }) async {
    try {
      await collection
          .doc(appliedId)
          .update({'state': ApplicationStatesModel.stateToString(nextState)});
      return Future.value([]);
    } catch (e) {
      print(e);
      return Future.value([const Unexpected(message: 'can\'t reject')]);
    }
  }

  @override
  bool get noMoreData => paginaterFirestore.noMoreData;

  @override
  void refresh() => paginaterFirestore.refresh();
}

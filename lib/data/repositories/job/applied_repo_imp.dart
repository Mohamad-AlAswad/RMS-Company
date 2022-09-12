import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/job/applied/applied_note.dart';

import '../../../core/errors/failures/failure.dart';
import '../../../domain/entities/job/applied/applied_job.dart';
import '../../../domain/entities/job/applied/full_applied_job.dart';
import '../../../domain/entities/job/applied/job_application_states.dart';
import '../../../domain/entities/user/user_info.dart' as user_ent;
import '../../../domain/repositories/job/applied_repo.dart';
import '../../../domain/repositories/user_info_repo.dart';
import '../../../injection_container.dart';
import '../../datasources/remote/evaluator_api.dart';
import '../../models/job/applied_job_model.dart';
import '../../models/job/applied_note_model.dart';
import '../../models/job/full_applied_job_model.dart';
import '../../models/job/job_application_states_model.dart';
import '../paginater_firestore.dart';

class AppliedRepoImp implements AppliedRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  final PaginaterFirestore paginaterFirestore;
  final ApplicationStates? applicationStates;
  final EvaluatorApi evaluatorApi;
  final UserInfoRepo userInfoRepo;

  AppliedRepoImp({
    required this.firebaseFirestore,
    required String jobId,
    this.applicationStates,
    required this.userInfoRepo,
  })  : evaluatorApi = sl(),
        collection = firebaseFirestore.collection('jobs-applications'),
        paginaterFirestore = applicationStates == null
            ? PaginaterFirestore(
                query: firebaseFirestore
                    .collection('jobs-applications')
                    .where('job-id', isEqualTo: jobId)
                    .orderBy('score'),
              )
            : PaginaterFirestore(
                query: firebaseFirestore
                    .collection('jobs-applications')
                    .where('job-id', isEqualTo: jobId)
                    .where(
                      'state',
                      isEqualTo: ApplicationStatesModel.stateToString(
                        applicationStates,
                      ),
                    )
                    .orderBy('score'),
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
      return Future.value(const Left(Unexpected()));
    }
  }

  @override
  Future<Either<Failure, List<AppliedJob>>> fetch({required int limit}) async {
    var response = await paginaterFirestore.fetch(limit: limit);
    return Future.value(Right(
      response!.docs
          .map((e) => AppliedJobModel.fromSnapshot(
        id: e.id,
        documentSnapshot: e.data() as Map<String, dynamic>,
      )!)
          .toList(),
    ));
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
      return Future.value([const Unexpected(message: 'can\'t reject')]);
    }
  }

  @override
  Future<List<Failure>> rateApplication({
    required AppliedJob appliedJob,
    required num rating,
  }) async {
    user_ent.UserInfo? user;
    (await userInfoRepo.getUserInfo(userId: appliedJob.jobSeekerId)).fold(
      (l) => user = null,
      (r) => user = r,
    );
    if (user != null) {
      print(user);
      num counter = user!.ratingCounter!;
      num oldRating = user!.rating! * counter;
      print(oldRating);
      oldRating += rating - appliedJob.rating;
      print(oldRating);
      if (appliedJob.rating == 0 && rating > 0) counter += 1;
      if (rating == 0 && appliedJob.rating > 0) counter -= 1;
      print(counter);
      num newRating = counter > 0 ? oldRating / counter : 0;
      print(newRating);

      userInfoRepo.updateRate(
        userId: appliedJob.jobSeekerId,
        rate: newRating,
        counter: counter,
      );
      collection.doc(appliedJob.appliedId).update({'rating': rating});
      return [];
    }
    return [];
  }

  @override
  bool get noMoreData => paginaterFirestore.noMoreData;

  @override
  void refresh() => paginaterFirestore.refresh();

  @override
  Future<List<Failure>> addNote({
    required AppliedJob appliedJob,
    required String note,
  }) async {
    appliedJob.notes.add(AppliedNote(note: note, state: appliedJob.state));
    await collection.doc(appliedJob.appliedId).update(
      {
        'notes': AppliedNoteModel.toSnapshot(appliedJob.notes),
      },
    );
    return [];
  }
}

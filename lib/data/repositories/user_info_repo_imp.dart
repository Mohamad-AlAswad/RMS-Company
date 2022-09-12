import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/repositories/authentication_repo.dart';

import '../../core/errors/failures/failure.dart';
import '../../domain/entities/user/user_info.dart';
import '../../domain/repositories/user_info_repo.dart';
import '../../injection_container.dart';
import '../models/user/user_info_model.dart';

class UserInfoRepoImp implements UserInfoRepo {
  final FirebaseFirestore firebaseFirestore;
  final CollectionReference<Map<String, dynamic>> collection;
  AuthenticationRepo? authenticationRepo;

  UserInfoRepoImp({
    required this.firebaseFirestore,
  }) : collection = firebaseFirestore.collection('user-info');

  @override
  Future<Either<Failure, UserInfo>> getUserInfo(
      {required String userId}) async {
    try {
      return Future.value(
        Right(UserInfoModel.fromSnapshot(
          documentSnapshot: (await collection.doc(userId).get()).data(),
          userId: userId,
        )!),
      );
    } catch (e) {
      return Future.value(const Left(Unexpected(message: 'unexpected')));
    }
  }

  @override
  Future<Either<Failure, bool>> updateUserInfo(
      {required UserInfo newUserInfo}) async {
    try {
      authenticationRepo ??= sl();
      await collection.doc(authenticationRepo!.userId!).update(
            UserInfoModel.toSnapshot(newUserInfo),
          );
      return Future.value(const Right(true));
    } catch (e) {
      return Future.value(const Right(false));
    }
  }

  @override
  Future<void> updateRate({
    required String userId,
    required num rate,
    required num counter,
  }) =>
      collection.doc(userId).update({
        'rate': rate,
        '--rating-counter': counter,
      });
}

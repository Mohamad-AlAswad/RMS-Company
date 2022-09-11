import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rms_company/data/models/user/user_info_model.dart';

import '../../../core/errors/exceptions/authentication_exceptions.dart';
import '../../../domain/entities/user/user_info.dart' as user_ent;
import '../../../domain/repositories/user_info_repo.dart';
import '../../../injection_container.dart';

abstract class AuthenticationRemote {
  Future<void> signInEmailPassword({
    required String email,
    required String password,
  });

  Future<void> signOut();

  Future<void> signUp({
    required String email,
    required String password,
  });

  String? get userId;

  user_ent.UserInfo? get connectedUser;
}

class FirebaseAuthentication extends AuthenticationRemote {
  final FirebaseAuth firebaseAuth;
  final UserInfoRepo userInfoRepo;
  static user_ent.UserInfo? _userInfo;
  static bool _initiated = false;

  FirebaseAuthentication({
    required this.userInfoRepo,
  }) : firebaseAuth = sl() {
    if (_initiated == false) {
      _initiated = true;
      _userInfo = null;
      firebaseAuth.authStateChanges().listen((event) async {
        if (event == null) {
          _userInfo = null;
        } else {
          (await userInfoRepo.getUserInfo(userId: event.uid)).fold(
            (l) => _userInfo = null,
            (r) => _userInfo = r,
          );
          if (userId != null) _update(userId!);
          if (_userInfo != null) {
            print('listen to: ${_userInfo!.id!}');
            FirebaseFirestore.instance
                .collection('user-info')
                .doc(_userInfo!.id)
                .snapshots()
                .listen((event) async {
              print(event);
              _update(event.id);
              print(_userInfo);
            });
          }
        }
      });
    }
  }

  Future<void> _update(String userId2) async {
    (await userInfoRepo.getUserInfo(userId: userId2)).fold(
      (l) => _userInfo = null,
      (r) => _userInfo = r,
    );
  }

  @override
  Future<void> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Future<void>.value(null);
    } on FirebaseAuthException {
      throw EmailAndPasswordNotMatchedException();
    } catch (e) {
      throw UnexpectedAuthException();
    }
  }

  @override
  Future<void> signOut() async {
    await firebaseAuth.signOut();
  }

  @override
  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    try {
      var temp = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await FirebaseFirestore.instance
          .collection('user-info')
          .doc(temp.user!.uid)
          .set(
            UserInfoModel.toSnapshot(
              user_ent.UserInfo(
                id: temp.user!.uid,
                email: email,
              ),
            ),
          );
      return Future<void>.value(null);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordException();
      } else if (e.code == 'invalid-email') {
        throw InvalidEmailException();
      } else if (e.code == 'email-already-in-use') {
        throw EmailAlreadyExistException();
      } else {
        throw UnexpectedAuthException();
      }
    } on Exception {
      throw UnexpectedAuthException();
    }
  }

  @override
  String? get userId {
    if (firebaseAuth.currentUser == null) return null;
    return firebaseAuth.currentUser!.uid;
  }

  @override
  user_ent.UserInfo? get connectedUser => _userInfo;
}

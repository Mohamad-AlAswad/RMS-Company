import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../core/errors/exceptions/authentication_exceptions.dart';
import '../../../domain/entities/company.dart';
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

  String? get companyId;

  Company? get connectedCompany;
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
    }
  }

  @override
  Future<void> signInEmailPassword({
    required String email,
    required String password,
  }) async {
    try {
      print('wtf');
      await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      print('wtf2 ');
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
      await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await userInfoRepo.updateUserInfo(
        newUserInfo: user_ent.UserInfo(
          id: (await FirebaseFirestore.instance.collection('user-info').add({}))
              .id,
          email: email,
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

  @override
  // TODO: implement companyId
  String? get companyId => 'throw UnimplementedError()';

  @override
  // TODO: implement connectedCompany
  Company? get connectedCompany => throw UnimplementedError();
}

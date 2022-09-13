import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:rms_company/domain/entities/company.dart';

import '../../core/errors/exceptions/authentication_exceptions.dart';
import '../../core/errors/failures/failure.dart';
import '../../domain/entities/user/user_info.dart' as user_ent;
import '../../domain/repositories/authentication_repo.dart';
import '../../domain/repositories/company_repo.dart';
import '../../injection_container.dart';
import '../datasources/remote/firebase_authentication.dart';

class AuthenticationUsingTwoSteps extends AuthenticationRepo {
  final AuthenticationRemote authenticationRemote;
  CompanyRepo? companyRepo;
  StreamSubscription? _stream;

  AuthenticationUsingTwoSteps() : authenticationRemote = sl();

  late String? _company;
  late Company? _companyInstance;

  @override
  Future<Either<Failure, void>> logOut() async {
    try {
      await authenticationRemote.signOut();
      connectedCompany = null;
      return Future<Either<Failure, void>>.value(const Right(null));
    } catch (e) {
      return Future<Either<Failure, void>>.value(const Left(Unexpected()));
    }
  }

  @override
  Future<Either<Failure, void>> signInEmailAndPassword(
      {required String email, required String password}) {
    return _signInUp(
      email: email,
      password: password,
      function: authenticationRemote.signInEmailPassword,
    );
  }

  @override
  Future<Either<Failure, void>> signUpEmailAndPassword(
      {required String email, required String password}) {
    return _signInUp(
      email: email,
      password: password,
      function: authenticationRemote.signUp,
    );
  }

  Future<Either<Failure, void>> _signInUp({
    required String email,
    required String password,
    required Function function,
  }) async {
    Failure failure;
    try {
      await function(email: email, password: password);
      return Future<Either<Failure, void>>.value(const Right(null));
    } on AuthenticationException catch (e) {
      failure = e.failure;
    } on Exception {
      failure = const Unexpected();
    }
    return Future<Either<Failure, void>>.value(Left(failure));
  }

  @override
  String? get userId => authenticationRemote.userId;

  @override
  user_ent.UserInfo? get connectedUser => authenticationRemote.connectedUser;

  @override
  List<String> get companies =>
      connectedUser == null ? [] : connectedUser!.companies;

  @override
  String? get connectedCompany => _company;

  @override
  set connectedCompany(String? company) {
    _stream?.cancel();
    _company = company;
    if (_company != null) {
      companyRepo ??= sl();
      _update();
      _stream = FirebaseFirestore.instance
          .collection('companies')
          .doc(_company)
          .snapshots()
          .listen((event) => _update());
    }
  }

  void _update() {
    companyRepo!
        .getCompany(company: _company!)
        .then((value) => _companyInstance = value)
        .then((value) {
    });
  }

  @override
  Company? get connectedCompanyInstance => _companyInstance;
}

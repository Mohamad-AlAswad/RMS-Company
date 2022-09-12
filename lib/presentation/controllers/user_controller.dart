import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/entities/entities.dart';
import '../../domain/usecases/authentication/get_connected_user.dart';
import 'controllers.dart';

class UserController {
  final PersonalControllers personalControllers;
  final CompanyController companyController;

  UserController({
    required this.personalControllers,
    required this.companyController,
  });
}

class TransformerUserController {
  static UserController fromUserInfo(UserInfo? userInfo) {
    userInfo = GetConnectedUser().connectedUser;
    return UserController(
      personalControllers: _convertPersonal(userInfo!),
      companyController: _convertComp(),
    );
  }

  static PersonalControllers _convertPersonal(UserInfo userInfo) {
    return PersonalControllers(
      fName: TextEditingController(text: userInfo.firstName),
      mName: TextEditingController(text: userInfo.middleName),
      lName: TextEditingController(text: userInfo.lastName),
      email: TextEditingController(text: userInfo.email),
      freeSpace: TextEditingController(text: userInfo.summary),
      tempGender: userInfo.gender,
      tempPhones:
          userInfo.phones.map((e) => TextEditingController(text: e)).toList(),
    );
  }

  static CompanyController _convertComp() {
    // String companyName = GetConnectedUser().connectedCompany!;
    // Company company = GetCompany()(company: companyName)!;
    Company company = Company(
      adminId: '123',
      name: 'miwdd',
      address: 'dasdasd',
      creationDate: Timestamp.now(),
      phones: const [],
      emails: const [],
    );
    return CompanyController(
      name: TextEditingController(text: company.name),
      address: TextEditingController(text: company.address),
      creationDate: TextEditingController(
        text: DateFormat.yMMMd().format(
          company.creationDate.toDate(),
        ),
      ),
      tempPhones:
          company.phones.map((e) => TextEditingController(text: e)).toList(),
      tempEmails:
          company.emails.map((e) => TextEditingController(text: e)).toList(),
    );
  }

  static UserInfo fromUserController(UserController userController) {
    return UserInfo(
      summary: userController.personalControllers.freeSpace.text,
      email: GetConnectedUser().connectedUser!.email,
      firstName: userController.personalControllers.fName.text,
      gender: userController.personalControllers.gender,
      lastName: userController.personalControllers.lName.text,
      middleName: userController.personalControllers.mName.text,
      phones:
          userController.personalControllers.phones.map((c) => c.text).toList(),
    );
  }
}

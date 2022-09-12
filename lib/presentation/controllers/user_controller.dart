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
      rating: userInfo.rating.toString(),
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
    Company company = GetConnectedUser().connectedCompanyInstance!;
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
    UserInfo userInfo = GetConnectedUser().connectedUser!;
    userInfo.summary = userController.personalControllers.freeSpace.text;
    userInfo.email = userController.personalControllers.email.text;
    userInfo.firstName = userController.personalControllers.fName.text;
    userInfo.gender = userController.personalControllers.gender;
    userInfo.lastName = userController.personalControllers.lName.text;
    userInfo.middleName = userController.personalControllers.mName.text;
    userInfo.phones =
        userController.personalControllers.phones.map((c) => c.text).toList();

    return userInfo;
  }

  static Company fromController(UserController userController) {
    return Company(
      adminId: GetConnectedUser().connectedCompanyInstance!.adminId,
      address: userController.companyController.address.text,
      name: userController.companyController.name.text,
      creationDate: Timestamp.fromDate(
        DateFormat.yMMMd()
            .parse(userController.companyController.creationDate.text),
      ),
      phones: userController.companyController.phones
          .map(
            (c) => c.text,
          )
          .toList(),
      emails: userController.companyController.emails
          .map(
            (c) => c.text,
          )
          .toList(),
    );
  }
}

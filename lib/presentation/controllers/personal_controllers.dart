import 'package:flutter/material.dart';

class PersonalControllers {
  final TextEditingController fName, mName, lName, email, freeSpace;

  late final List<TextEditingController> phones, emails;

  late final String gender, rating;

  PersonalControllers({
    required this.fName,
    required this.mName,
    required this.lName,
    required this.email,
    required this.rating,
    required this.freeSpace,
    required List<TextEditingController>? tempPhones,
    required List<TextEditingController>? tempEmails,
    required String? tempGender,
  })  : gender = tempGender ?? '',
        phones = tempPhones ?? [],
        emails = tempEmails ?? [];
}

import 'package:flutter/material.dart';

class CompanyController {
  final TextEditingController name, address, creationDate;
  late final List<TextEditingController> phones, emails;

  CompanyController({
    required this.name,
    required this.address,
    required this.creationDate,
    required List<TextEditingController>? tempPhones,
    required List<TextEditingController>? tempEmails,
  })  : phones = tempPhones ?? [],
        emails = tempEmails ?? [];
}

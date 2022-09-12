import 'package:rms_company/core/utils/custom_converter.dart';

import '../../domain/entities/company.dart';

class CompanyModel extends Company {
  const CompanyModel({
    required super.adminId,
    required super.name,
    required super.address,
    required super.creationDate,
    required super.phones,
    required super.emails,
  });

  static Company? fromSnapshot({
    required Map<String, dynamic>? documentSnapshot,
  }) {
    if (documentSnapshot == null) return null;
    return Company(
      adminId: documentSnapshot['admin-id'],
      name: documentSnapshot['company-name'],
      address: documentSnapshot['address'],
      creationDate: documentSnapshot['creation-date'],
      phones: CustomConverter().toListString(list: documentSnapshot['phones']),
      emails: CustomConverter().toListString(list: documentSnapshot['emails']),
    );
  }

  static Map<String, dynamic> toSnapshot(Company company) {
    return {
      'admin-id': company.adminId,
      'company-name': company.name,
      'address': company.address,
      'creation-date': company.creationDate,
      'emails': company.emails,
      'phones': company.phones,
    };
  }
}

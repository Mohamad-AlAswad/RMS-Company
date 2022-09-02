import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String? email;
  final List<String> phones;
  final List<String> emails;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? imgUrl;
  final String? gender;
  final String? location;
  final String? summary;
  final String? nationality;
  final List<String> companies;

  const UserInfo({
    this.email,
    this.firstName,
    this.middleName,
    this.lastName,
    this.imgUrl,
    this.gender,
    this.location,
    this.phones = const [],
    this.emails = const [],
    this.summary,
    this.nationality,
    this.companies = const [],
  });

  @override
  List<Object?> get props => [
        email,
        firstName,
        middleName,
        lastName,
        imgUrl,
        gender,
        location,
        phones,
        emails,
        summary,
        nationality,
        companies,
      ];
}

import 'package:equatable/equatable.dart';

class UserInfo extends Equatable {
  final String? id;
  final String? email;
  final List<String> phones;
  final List<String> emails;
  final String? firstName;
  final String? middleName;
  final String? lastName;
  final String? imgUrl;
  final String? gender;
  final String? location;
  final String? nationality;
  final List<String> companies;

  const UserInfo({
    this.id,
    this.email,
    this.firstName,
    this.middleName,
    this.lastName,
    this.imgUrl,
    this.gender,
    this.location,
    this.nationality,
    this.phones = const [],
    this.emails = const [],
    this.companies = const [],
  });

  @override
  List<Object?> get props => [
        id,
        email,
        firstName,
        middleName,
        lastName,
        imgUrl,
        gender,
        location,
        phones,
        emails,
        nationality,
        companies,
      ];
}

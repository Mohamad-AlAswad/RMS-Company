import 'package:validators/validators.dart';

import '../../../data/repositories/keywords/keywords_degree_edu_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_field_edu_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_job_titles_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_languages_repo_substring.dart';
import '../../../data/repositories/keywords/keywords_skills_repo_substring.dart';
import '../../../domain/entities/user/user_info.dart';
import '../../../domain/repositories/keywords/keywords_degree_edu_repo.dart';
import '../../../domain/repositories/keywords/keywords_field_edu_repo.dart';
import '../../../domain/repositories/keywords/keywords_job_titles_repo.dart';
import '../../../domain/repositories/keywords/keywords_languages_repo.dart';
import '../../../domain/repositories/keywords/keywords_skills_repo.dart';
import '../../errors/failures/user_info_failures.dart';

class UserInfoValidator {
  static Future<List<UserInfoFailure>> validate(UserInfo userInfo) async {
    List<UserInfoFailure> errors = [];
    bool invalidEmail = _validateEmails(userInfo.emails);
    bool invalidPhone = _validatePhone(userInfo.phones);

    // if (invalidEmail) errors.add(const InvalidEmailUserInfoFailure());
    if (invalidPhone) errors.add(const InvalidPhoneUserInfoFailure());

    return Future<List<UserInfoFailure>>.value(errors);
  }

  static bool _validateEmails(List<String> emails) =>
      emails.map((e) => !isEmail(e)).isNotEmpty;

  static bool _validatePhone(List<String> phones) => false;
}

import 'package:validators/validators.dart';

import '../../errors/failures/user_info_failures.dart';
import '../../../domain/entities/user/user_info.dart';

class UserInfoValidator {
  static Future<List<UserInfoFailure>> validate(UserInfo userInfo) async {
    List<UserInfoFailure> errors = [];
    bool invalidEmail = _validateEmails(userInfo.emails);
    bool invalidPhone = _validatePhone(userInfo.phones);

    if (invalidEmail) errors.add(const InvalidEduUserInfoFailure());
    if (invalidPhone) errors.add(const InvalidPhoneUserInfoFailure());

    return Future<List<UserInfoFailure>>.value(errors);
  }

  static bool _validateEmails(List<String> emails) =>
      emails.map((e) => !isEmail(e)).isNotEmpty;

  static bool _validatePhone(List<String> phones) => false;
}

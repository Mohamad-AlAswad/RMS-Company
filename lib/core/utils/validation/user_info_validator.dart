
import '../../../domain/entities/user/user_info.dart';
import '../../errors/failures/user_info_failures.dart';

class UserInfoValidator {
  static Future<List<UserInfoFailure>> validate(UserInfo userInfo) async {
    List<UserInfoFailure> errors = [];
    bool invalidPhone = _validatePhone(userInfo.phones);

    if (invalidPhone) errors.add(const InvalidPhoneUserInfoFailure());

    return Future<List<UserInfoFailure>>.value(errors);
  }


  static bool _validatePhone(List<String> phones) => false;
}

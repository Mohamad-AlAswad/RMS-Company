import '../../../core/utils/custom_converter.dart';
import '../../../domain/entities/user/user_info.dart';

class UserInfoModel extends UserInfo {
  static UserInfo? fromSnapshot(
      {required Map<String, dynamic>? documentSnapshot}) {
    if (documentSnapshot == null) return null;
    return UserInfo(
      firstName: documentSnapshot['first-name'],
      middleName: documentSnapshot['middle-name'],
      lastName: documentSnapshot['last-name'],
      email: documentSnapshot['email'],
      imgUrl: documentSnapshot['img-url'],
      gender: documentSnapshot['gender'],
      location: documentSnapshot['location'],
      nationality: documentSnapshot['nationality'],
      emails: CustomConverter.toListString(documentSnapshot['emails']),
      phones: CustomConverter.toListString(documentSnapshot['phones']),
      companies: CustomConverter.toListString(documentSnapshot['companies']),
    );
  }

  static Map<String, dynamic> toSnapshot(UserInfo userInfo) {
    return {
      'email': userInfo.email,
      'first-name': userInfo.firstName,
      'middle-name': userInfo.middleName,
      'last-name': userInfo.lastName,
      'img-url': userInfo.imgUrl,
      'gender': userInfo.gender,
      'location': userInfo.location,
      'nationality': userInfo.nationality,
      'emails': userInfo.emails,
      'phones': userInfo.phones,
      'companies': userInfo.companies,
    };
  }
}

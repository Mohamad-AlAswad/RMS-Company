import 'package:rms_company/domain/entities/job_seeker/job_seeker_info.dart';
import 'education_certificate_model.dart';
import 'past_job_model.dart';

class JobSeekerInfoModel extends JobSeekerInfo {
  static JobSeekerInfo? fromSnapshot(
      {required Map<String, dynamic>? documentSnapshot}) {
    if (documentSnapshot == null) return null;
    return JobSeekerInfo(
      summary: documentSnapshot['summary'],
      email: documentSnapshot['email'],
      firstName: documentSnapshot['first-name'],
      middleName: documentSnapshot['middle-name'],
      lastName: documentSnapshot['last-name'],
      imgUrl: documentSnapshot['img-url'],
      gender: documentSnapshot['gender'],
      location: documentSnapshot['location'],
      nationality: documentSnapshot['nationality'],
      rating: documentSnapshot['rating'],
      emails: _convertToListString(documentSnapshot['emails']),
      phones: _convertToListString(documentSnapshot['phones']),
      languages: _convertToListString(documentSnapshot['languages']),
      skills: _convertToListString(documentSnapshot['skills']),
      experiences: PastJobModel.listFromSnapshot(
          _convertToListMap(documentSnapshot['experiences'])),
      eduQualifications: EducationCertificateModel.listFromSnapshot(
          _convertToListMap(documentSnapshot['edu-qualifications'])),
    );
  }

  static List<String> _convertToListString(List<dynamic> list) {
    return list.map((e) => e as String).toList();
  }

  static List<Map<String, dynamic>> _convertToListMap(List<dynamic> list) {
    return list.map((e) => e as Map<String, dynamic>).toList();
  }

  static Map<String, dynamic> toSnapshot(JobSeekerInfo jobSeekerInfo) {
    return {
      'summary': jobSeekerInfo.summary,
      'email': jobSeekerInfo.email,
      'first-name': jobSeekerInfo.firstName,
      'middle-name': jobSeekerInfo.middleName,
      'last-name': jobSeekerInfo.lastName,
      'img-url': jobSeekerInfo.imgUrl,
      'gender': jobSeekerInfo.gender,
      'location': jobSeekerInfo.location,
      'nationality': jobSeekerInfo.nationality,
      'rating': jobSeekerInfo.rating,
      'emails': jobSeekerInfo.emails,
      'phones': jobSeekerInfo.phones,
      'languages': jobSeekerInfo.languages,
      'skills': jobSeekerInfo.skills,
      'experiences': PastJobModel.listToSnapshot(jobSeekerInfo.experiences),
      'edu-qualifications': EducationCertificateModel.listToSnapshot(
          jobSeekerInfo.eduQualifications),
    };
  }
}

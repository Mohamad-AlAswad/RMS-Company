import '../../../domain/entities/job/job.dart';
import 'description_field/description_field_model.dart';

class JobModel extends Job {
  const JobModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.publishedTime,
    required super.skills,
    required super.eduQualifications,
    required super.experiences,
    required super.languages,
    required super.status,
  });

  static Job? fromSnapshot(
      {String? id, Map<String, dynamic>? documentSnapshot}) {
    try {
      return Job(
        id: id!,
        title: documentSnapshot!['title'],
        summary: documentSnapshot['summary'],
        publishedTime: documentSnapshot['published-time'],
        status: documentSnapshot['status'],
        skills: SkillDescriptionFieldModel.fromListSnapshot(
          documentSnapshot['skills'],
        )!,
        eduQualifications:
            EduQualificationDescriptionFieldModel.fromListSnapshot(
          documentSnapshot['edu-qualifications'],
        )!,
        experiences: ExperienceDescriptionFieldModel.fromListSnapshot(
          documentSnapshot['experiences'],
        )!,
        languages: LanguageDescriptionFieldModel.fromListSnapshot(
          documentSnapshot['languages'],
        )!,
      );
    } catch (e) {
      return null;
    }
  }

  static Map<String, dynamic> toSnapshot({
    required Job job,
    required String companyName,
  }) {
    return {
      'title': job.title,
      'summary': job.summary,
      'published-time': job.publishedTime,
      'status': job.status,
      'company-name': companyName,
      'skills': SkillDescriptionFieldModel.listToSnapshot(job.skills),
      'edu-qualifications':
          EduQualificationDescriptionFieldModel.listToSnapshot(
        job.eduQualifications,
      ),
      'experiences':
          ExperienceDescriptionFieldModel.listToSnapshot(job.experiences),
      'languages': LanguageDescriptionFieldModel.listToSnapshot(job.languages),
    };
  }
}

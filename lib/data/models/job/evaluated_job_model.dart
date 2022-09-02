import '../../../domain/entities/job/evaluated_job.dart';
import 'evaluated_description/evaluated_description_model.dart';

class EvaluatedJobModel extends EvaluatedJob {
  const EvaluatedJobModel({
    required super.id,
    required super.title,
    required super.summary,
    required super.companyName,
    required super.publishedTime,
    required super.skills,
    required super.eduQualifications,
    required super.experiences,
    required super.languages,
    required super.score,
  });

  static EvaluatedJob? fromJsonAndSnapshot({
    required Map<String, dynamic>? jsonData,
    required Map<String, dynamic>? documentSnapshot,
    required String id,
  }) {
    try {
      return EvaluatedJob(
        id: id,
        title: documentSnapshot!['title'],
        summary: documentSnapshot['summary'],
        companyName: documentSnapshot['company-name'],
        publishedTime: documentSnapshot['published-time'],
        skills: EvSkillDescriptionModel.fromJsonAndSnapshot(
          jsonData: jsonData!['skills'],
          documentSnapshot: documentSnapshot['skills'],
        )!,
        eduQualifications:
            EvEduQualificationDescriptionModel.fromJsonAndSnapshot(
          jsonData: jsonData['edu-qualifications'],
          documentSnapshot: documentSnapshot['edu-qualifications'],
        )!,
        experiences: EvExperienceDescriptionModel.fromJsonAndSnapshot(
          jsonData: jsonData['experiences'],
          documentSnapshot: documentSnapshot['experiences'],
        )!,
        languages: EvLanguageDescriptionModel.fromJsonAndSnapshot(
          jsonData: jsonData['languages'],
          documentSnapshot: documentSnapshot['languages'],
        )!,
        score: jsonData['score'],
      );
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}

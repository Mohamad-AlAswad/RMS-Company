import 'package:rms_company/data/models/job/evaluated_description/applied_description_model.dart';

import '../../../domain/entities/job/applied/applied_job.dart';

class AppliedJobModel extends AppliedJob {
  const AppliedJobModel({
    required super.appliedId,
    required super.fullName,
    required super.jobSeekerId,
    required super.appliedTime,
    required super.summary,
    required super.skills,
    required super.eduQualifications,
    required super.experiences,
    required super.languages,
    required super.score,
    required super.state,
  });

  static AppliedJob? fromSnapshot({
    required String id,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return AppliedJob(
        appliedId: id,
        fullName: documentSnapshot!['full-name'],
        jobSeekerId: documentSnapshot['job-seeker-id'],
        appliedTime: documentSnapshot['applied-time'],
        summary: documentSnapshot['summary'],
        score: documentSnapshot['score'],
        state: documentSnapshot['state'],
        skills: ApSkillDescriptionModel.fromSnapshot(
          documentSnapshot['skills'],
        )!,
        eduQualifications: ApEduQualificationDescriptionModel.fromSnapshot(
          documentSnapshot['edu-qualifications'],
        )!,
        experiences: ApExperienceDescriptionModel.fromSnapshot(
          documentSnapshot['experiences'],
        )!,
        languages: ApLanguageDescriptionModel.fromSnapshot(
          documentSnapshot['languages'],
        )!,
      );
    } catch (e) {
      return null;
    }
  }
}

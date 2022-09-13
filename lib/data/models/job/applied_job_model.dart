import 'package:rms_company/data/models/job/applied_note_model.dart';

import '../../../domain/entities/job/applied/applied_job.dart';
import 'evaluated_description/applied_description_model.dart';

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
    required super.notes,
    required super.rating,
  });

  static AppliedJob? fromSnapshot({
    required String id,
    required Map<String, dynamic>? documentSnapshot,
  }) {
    try {
      return AppliedJob(
        appliedId: id,
        fullName: documentSnapshot!['full-name-job-seeker'],
        jobSeekerId: documentSnapshot['job-seeker-id'],
        appliedTime: documentSnapshot['applied-time'],
        summary: documentSnapshot['summary-job-seeker'],
        score: documentSnapshot['score'],
        state: documentSnapshot['state'],
        rating: documentSnapshot['rating'],
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
        notes: AppliedNoteModel.fromSnapshot(documentSnapshot['notes'])!,
      );
    } catch (e) {
      return null;
    }
  }
}

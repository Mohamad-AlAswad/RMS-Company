import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:rms_company/domain/entities/job/applied/applied_note.dart';

import 'applied_description/applied_description.dart';

class AppliedJob extends Equatable {
  final String fullName;
  final String appliedId;
  final String jobSeekerId;
  final String summary;
  final Timestamp appliedTime;
  final String state;
  final List<ApSkillDescription> skills;
  final List<ApEduQualificationDescription> eduQualifications;
  final List<ApExperienceDescription> experiences;
  final List<ApLanguageDescription> languages;
  final num score;
  final num rating;
  final List<AppliedNote> notes;

  const AppliedJob({
    required this.appliedId,
    required this.fullName,
    required this.jobSeekerId,
    required this.appliedTime,
    required this.summary,
    required this.skills,
    required this.eduQualifications,
    required this.experiences,
    required this.languages,
    required this.score,
    required this.rating,
    required this.state,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        appliedId,
        fullName,
        jobSeekerId,
        appliedTime,
        summary,
        skills,
        eduQualifications,
        experiences,
        languages,
        score,
        rating,
        state,
        notes,
      ];
}

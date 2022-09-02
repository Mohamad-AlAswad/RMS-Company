import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'evaluated_description/evaluated_description.dart';

class EvaluatedJob extends Equatable {
  final String fullName;
  final String appliedId;
  final String userId;
  final String summary;
  final Timestamp appliedTime;
  final String state;
  final List<EvSkillDescription> skills;
  final List<EvEduQualificationDescription> eduQualifications;
  final List<EvExperienceDescription> experiences;
  final List<EvLanguageDescription> languages;
  final num score;

  const EvaluatedJob({
    required this.appliedId,
    required this.fullName,
    required this.userId,
    required this.appliedTime,
    required this.summary,
    required this.skills,
    required this.eduQualifications,
    required this.experiences,
    required this.languages,
    required this.score,
    required this.state,
  });

  @override
  List<Object?> get props => [
        appliedId,
        fullName,
        userId,
        appliedTime,
        summary,
        skills,
        eduQualifications,
        experiences,
        languages,
        score,
        state,
      ];
}

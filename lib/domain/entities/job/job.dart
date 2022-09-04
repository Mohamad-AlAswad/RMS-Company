import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

import 'description_field/description_field.dart';

class Job extends Equatable {
  final String id;
  final String title;
  final String summary;
  final Timestamp publishedTime;
  final List<SkillDescriptionField> skills;
  final List<EduQualificationDescriptionField> eduQualifications;
  final List<ExperienceDescriptionField> experiences;
  final List<LanguageDescriptionField> languages;
  final String status;

  const Job({
    required this.id,
    required this.title,
    required this.summary,
    required this.publishedTime,
    required this.skills,
    required this.eduQualifications,
    required this.experiences,
    required this.languages,
    required this.status,
  });

  @override
  List<Object?> get props => [
        id,
        title,
        summary,
        publishedTime,
        skills,
        eduQualifications,
        experiences,
        languages,
        status,
      ];
}

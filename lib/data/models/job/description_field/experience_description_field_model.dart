part of 'description_field_model.dart';

class ExperienceDescriptionFieldModel extends ExperienceDescriptionField {
  const ExperienceDescriptionFieldModel({
    required super.title,
    required super.period,
    required super.isRequired,
  });

  static List<ExperienceDescriptionField>? fromListSnapshot(
    List<dynamic>? documentSnapshot,
  ) {
    try {
      return documentSnapshot!.map((e) => _fromSnapshot(e)!).toList();
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> listToSnapshot(
      List<ExperienceDescriptionField> list) {
    return list.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    ExperienceDescriptionField experienceDescriptionField,
  ) {
    return {
      'title': experienceDescriptionField.title,
      'period': experienceDescriptionField.period,
      'is-required': experienceDescriptionField.isRequired,
    };
  }

  static ExperienceDescriptionField? _fromSnapshot(
    Map<String, dynamic>? documentSnapshot,
  ) {
    try {
      return ExperienceDescriptionField(
        title: documentSnapshot!['title'],
        period: documentSnapshot['period'],
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}

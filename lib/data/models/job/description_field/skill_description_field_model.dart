part of 'description_field_model.dart';

class SkillDescriptionFieldModel extends SkillDescriptionField {
  const SkillDescriptionFieldModel({
    required super.title,
    required super.isRequired,
  });

  static List<SkillDescriptionField>? fromListSnapshot(
    List<dynamic>? documentSnapshot,
  ) {
    try {
      return documentSnapshot!.map((e) => _fromSnapshot(e)!).toList();
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> listToSnapshot(
      List<SkillDescriptionField> list) {
    return list.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    SkillDescriptionField skillDescriptionField,
  ) {
    return {
      'title': skillDescriptionField.title,
      'is-required': skillDescriptionField.isRequired,
    };
  }

  static SkillDescriptionField? _fromSnapshot(
    Map<String, dynamic>? documentSnapshot,
  ) {
    try {
      return SkillDescriptionField(
        title: documentSnapshot!['title'],
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}

part of 'description_field_model.dart';

class EduQualificationDescriptionFieldModel
    extends EduQualificationDescriptionField {
  const EduQualificationDescriptionFieldModel({
    required super.degree,
    required super.field,
    required super.isRequired,
  });

  static List<EduQualificationDescriptionField>? fromListSnapshot(
    List<dynamic>? documentSnapshot,
  ) {
    try {
      return documentSnapshot!.map((e) => _fromSnapshot(e)!).toList();
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> listToSnapshot(
      List<EduQualificationDescriptionField> list) {
    return list.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    EduQualificationDescriptionField eduQualificationDescriptionField,
  ) {
    return {
      'degree': eduQualificationDescriptionField.degree,
      'field': eduQualificationDescriptionField.field,
      'is-required': eduQualificationDescriptionField.isRequired,
    };
  }

  static EduQualificationDescriptionField? _fromSnapshot(
    Map<String, dynamic>? documentSnapshot,
  ) {
    try {
      return EduQualificationDescriptionField(
        degree: documentSnapshot!['degree'],
        field: documentSnapshot['field'],
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}

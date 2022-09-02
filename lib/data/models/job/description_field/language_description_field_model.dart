part of 'description_field_model.dart';

class LanguageDescriptionFieldModel extends LanguageDescriptionField {
  const LanguageDescriptionFieldModel({
    required super.title,
    required super.isRequired,
  });

  static List<LanguageDescriptionField>? fromListSnapshot(
    List<dynamic>? documentSnapshot,
  ) {
    try {
      return documentSnapshot!.map((e) => _fromSnapshot(e)!).toList();
    } catch (e) {
      return null;
    }
  }

  static List<Map<String, dynamic>> listToSnapshot(
      List<LanguageDescriptionField> list) {
    return list.map((e) => _toSnapshot(e)).toList();
  }

  static Map<String, dynamic> _toSnapshot(
    LanguageDescriptionField languageDescriptionField,
  ) {
    return {
      'title': languageDescriptionField.title,
      'is-required': languageDescriptionField.isRequired,
    };
  }

  static LanguageDescriptionField? _fromSnapshot(
    Map<String, dynamic>? documentSnapshot,
  ) {
    try {
      return LanguageDescriptionField(
        title: documentSnapshot!['title'],
        isRequired: documentSnapshot['is-required'],
      );
    } catch (e) {
      return null;
    }
  }
}

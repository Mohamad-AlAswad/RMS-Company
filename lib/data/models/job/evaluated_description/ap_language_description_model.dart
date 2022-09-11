part of 'applied_description_model.dart';

class ApLanguageDescriptionModel extends ApLanguageDescription {
  const ApLanguageDescriptionModel({
    required super.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<ApLanguageDescription>? fromSnapshot(
    List<dynamic>? documentSnapshot,
  ) {
    try {
      return documentSnapshot!
          .map((e) => _fromSnapshot(e)!)
          .where((element) => element.isRequired == false)
          .toList();
    } catch (e) {
      return null;
    }
  }

  static ApLanguageDescription? _fromSnapshot(
    Map<String, dynamic> documentSnapshot,
  ) {
    return ApLanguageDescription(
      title: documentSnapshot['title'],
      isRequired: documentSnapshot['is-required'],
      isSatisfied: documentSnapshot['is-satisfied'],
    );
  }
}

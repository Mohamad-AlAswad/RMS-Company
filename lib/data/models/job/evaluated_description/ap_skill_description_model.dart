part of 'applied_description_model.dart';

class ApSkillDescriptionModel extends ApSkillDescription {
  const ApSkillDescriptionModel({
    required super.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<ApSkillDescription>? fromSnapshot(
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

  static ApSkillDescription? _fromSnapshot(
    Map<String, dynamic> documentSnapshot,
  ) {
    return ApSkillDescription(
      title: documentSnapshot['title'],
      isRequired: documentSnapshot['is-required'],
      isSatisfied: documentSnapshot['is-satisfied'],
    );
  }
}

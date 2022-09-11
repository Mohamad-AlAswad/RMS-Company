part of 'applied_description_model.dart';

class ApExperienceDescriptionModel extends ApExperienceDescription {
  const ApExperienceDescriptionModel({
    required super.title,
    required super.period,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<ApExperienceDescription>? fromSnapshot(
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

  static ApExperienceDescription? _fromSnapshot(
    Map<String, dynamic> documentSnapshot,
  ) {
    return ApExperienceDescription(
      title: documentSnapshot['title'],
      isSatisfied: documentSnapshot['is-satisfied'],
      isRequired: documentSnapshot['is-required'],
      period: documentSnapshot['period'],
    );
  }
}

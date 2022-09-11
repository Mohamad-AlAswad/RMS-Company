part of 'applied_description_model.dart';

class ApEduQualificationDescriptionModel extends ApEduQualificationDescription {
  const ApEduQualificationDescriptionModel({
    required super.degree,
    required super.field,
    required super.isSatisfied,
    required super.isRequired,
  });

  static List<ApEduQualificationDescription>? fromSnapshot(
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

  static ApEduQualificationDescription? _fromSnapshot(
    Map<String, dynamic> documentSnapshot,
  ) {
    return ApEduQualificationDescription(
      isSatisfied: documentSnapshot['is-satisfied'],
      isRequired: documentSnapshot['is-required'],
      degree: documentSnapshot['degree'],
      field: documentSnapshot['field'],
    );
  }
}

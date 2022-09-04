import '../../../../domain/entities/job/applied/applied_description/applied_description.dart';

part 'ap_edu_qualification_description_model.dart';
part 'ap_experience_description_model.dart';
part 'ap_language_description_model.dart';
part 'ap_skill_description_model.dart';

abstract class AppliedDescriptionModel extends AppliedDescription {
  const AppliedDescriptionModel({
    required super.isSatisfied,
    required super.isRequired,
  });
}

import '../../../../domain/entities/job/description_field/description_field.dart';

part 'skill_description_field_model.dart';

part 'edu_qualification_description_field_model.dart';

part 'experience_description_field_model.dart';

part 'language_description_field_model.dart';

abstract class DescriptionFieldModel extends DescriptionField {
  const DescriptionFieldModel({required super.isRequired});
}

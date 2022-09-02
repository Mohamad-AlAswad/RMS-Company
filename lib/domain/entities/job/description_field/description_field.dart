import 'package:equatable/equatable.dart';

part 'skill_description_field.dart';

part 'edu_qualification_description_field.dart';

part 'experience_description_field.dart';

part 'language_description_field.dart';

abstract class DescriptionField extends Equatable {
  final bool isRequired;

  const DescriptionField({
    required this.isRequired,
  });
}

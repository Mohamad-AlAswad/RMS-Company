part of 'description_field.dart';

class SkillDescriptionField extends DescriptionField {
  final String title;

  const SkillDescriptionField({
    required this.title,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        title,
        isRequired,
      ];
}

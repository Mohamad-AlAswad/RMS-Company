part of 'description_field.dart';

class ExperienceDescriptionField extends DescriptionField {
  final String title;
  final num period;

  const ExperienceDescriptionField({
    required this.title,
    required this.period,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        title,
        period,
        isRequired,
      ];
}

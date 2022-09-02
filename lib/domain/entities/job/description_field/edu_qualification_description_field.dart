part of 'description_field.dart';

class EduQualificationDescriptionField extends DescriptionField {
  final String degree;
  final String field;

  const EduQualificationDescriptionField({
    required this.degree,
    required this.field,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        degree,
        field,
        isRequired,
      ];
}

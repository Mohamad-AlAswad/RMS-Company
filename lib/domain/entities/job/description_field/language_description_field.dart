part of 'description_field.dart';

class LanguageDescriptionField extends DescriptionField {
  final String title;

  const LanguageDescriptionField({
    required this.title,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        title,
        isRequired,
      ];
}

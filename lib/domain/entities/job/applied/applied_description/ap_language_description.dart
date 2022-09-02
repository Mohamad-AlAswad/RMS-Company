part of 'applied_description.dart';

class ApLanguageDescription extends AppliedDescription {
  final String title;

  const ApLanguageDescription({
    required this.title,
    required super.isSatisfied,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        title,
        isSatisfied,
        isRequired,
      ];
}

part of 'applied_description.dart';

class ApSkillDescription extends AppliedDescription {
  final String title;

  const ApSkillDescription({
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

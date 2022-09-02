part of 'applied_description.dart';

class ApExperienceDescription extends AppliedDescription {
  final String title;
  final num period;

  const ApExperienceDescription({
    required this.title,
    required this.period,
    required super.isSatisfied,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        title,
        period,
        isSatisfied,
        isRequired,
      ];
}

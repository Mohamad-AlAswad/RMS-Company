part of 'applied_description.dart';

class ApEduQualificationDescription extends AppliedDescription {
  final String degree;
  final String field;

  const ApEduQualificationDescription({
    required this.degree,
    required this.field,
    required super.isSatisfied,
    required super.isRequired,
  });

  @override
  List<Object?> get props => [
        degree,
        field,
        isSatisfied,
        isRequired,
      ];
}

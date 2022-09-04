import 'package:equatable/equatable.dart';

part 'ap_edu_qualification_description.dart';
part 'ap_experience_description.dart';
part 'ap_language_description.dart';
part 'ap_skill_description.dart';

abstract class AppliedDescription extends Equatable {
  final bool isSatisfied;
  final bool isRequired;

  const AppliedDescription({
    required this.isSatisfied,
    required this.isRequired,
  });
}

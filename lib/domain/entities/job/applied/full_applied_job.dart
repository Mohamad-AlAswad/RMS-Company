import 'package:equatable/equatable.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';


class FullAppliedJob extends Equatable {
  final AppliedJob appliedJob;

  const FullAppliedJob({
    required this.appliedJob,
  });

  @override
  List<Object?> get props => [appliedJob];
}

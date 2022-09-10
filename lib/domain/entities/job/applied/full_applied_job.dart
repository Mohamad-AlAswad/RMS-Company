import 'package:equatable/equatable.dart';

import '../../../usecases/job/applied/applied_note.dart';
import 'applied_job.dart';

class FullAppliedJob extends Equatable {
  final AppliedJob appliedJob;
  final List<AppliedNote> notes;

  const FullAppliedJob({
    required this.appliedJob,
    required this.notes,
  });

  @override
  List<Object?> get props => [
        appliedJob,
        notes,
      ];
}


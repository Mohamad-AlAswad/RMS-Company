import 'package:equatable/equatable.dart';

import 'applied_job.dart';
import 'applied_note.dart';

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

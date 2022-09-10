import 'package:rms_company/data/models/job/applied_note_model.dart';

import '../../../domain/entities/job/applied/full_applied_job.dart';
import 'applied_job_model.dart';

class FullAppliedJobModel extends FullAppliedJob {
  const FullAppliedJobModel({
    required super.appliedJob,
    required super.notes,
  });

  static FullAppliedJob? fromSnapshot({
    required String id,
    required Map<String, dynamic>? documentSnapshot,
  }) =>
      FullAppliedJob(
        appliedJob: AppliedJobModel.fromSnapshot(
          id: id,
          documentSnapshot: documentSnapshot,
        )!,
        notes: []
      );

}

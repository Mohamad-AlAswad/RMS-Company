import '../../../domain/entities/job/applied/full_applied_job.dart';
import 'applied_job_model.dart';

class FullAppliedJobModel extends FullAppliedJob {
  const FullAppliedJobModel({required super.appliedJob});

  static FullAppliedJobModel? fromSnapshot({
    required String id,
    required Map<String, dynamic>? documentSnapshot,
  }) =>
      FullAppliedJobModel(
        appliedJob: AppliedJobModel.fromSnapshot(
            id: id, documentSnapshot: documentSnapshot)!,
      );
}

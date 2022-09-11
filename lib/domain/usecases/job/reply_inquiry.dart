import '../../../injection_container.dart';
import '../../entities/job/inquiry_job.dart';
import '../../entities/job/job.dart';
import '../../repositories/job/job_repo.dart';

class ReplyInquiry {
  final JobRepo jobRepo;

  ReplyInquiry() : jobRepo = sl();

  Future<List<String>> call({
    required Job job,
    required InquiryJob inquiryJob,
    required String answer,
  }) async =>
      (await jobRepo.replyInquiry(
        job: job,
        inquiryJob: inquiryJob,
        answer: answer,
      ))
          .map((e) => e.message)
          .toList();
}

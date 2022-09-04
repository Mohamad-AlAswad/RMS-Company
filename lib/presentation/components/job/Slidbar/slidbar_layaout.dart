import 'package:flutter/material.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';

import '../../../../domain/entities/job/job.dart';
import '../../../../domain/usecases/job/applied/fetch_more.dart';
import 'applicant_page.dart';
import 'info_page.dart';

class SlidBarLayout extends StatefulWidget {
  const SlidBarLayout({
    Key? key,
    required this.job,
  }) : super(key: key);

  final Job job;

  @override
  State<SlidBarLayout> createState() => _SlidBarLayoutState();
}

class _SlidBarLayoutState extends State<SlidBarLayout> {

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        InfoPage(job: widget.job),
        ApplicantPage(job: widget.job),
      ],
    );
  }
}

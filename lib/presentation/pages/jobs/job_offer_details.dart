import 'package:flutter/material.dart';
import 'package:rms_company/domain/entities/entities.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';
import 'package:rms_company/domain/usecases/job/applied/fetch_more.dart';

import '../../components/components.dart';
import '../../components/job/Slidbar/slidbar_layaout.dart';

class JobOfferDetails extends StatefulWidget {
  const JobOfferDetails({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  State<JobOfferDetails> createState() => _JobOfferDetailsState();
}

class _JobOfferDetailsState extends State<JobOfferDetails> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        label: widget.job.title,
        actions: [TextButton(onPressed: () {}, child: const Text('Delete'))],
        leading: true,
      ),
      body: SlidBarLayout(job: widget.job),
    );
  }
}

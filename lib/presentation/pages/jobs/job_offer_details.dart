import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../domain/entities/entities.dart';
import '../../../domain/usecases/job/remove_job.dart';
import '../../components/components.dart';
import 'Slidbar/slidbar_layaout.dart';

class JobOfferDetails extends StatefulWidget {
  const JobOfferDetails({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  State<JobOfferDetails> createState() => _JobOfferDetailsState();
}

class _JobOfferDetailsState extends State<JobOfferDetails> {
  late RemoveJob removeJob;

  @override
  void initState() {
    super.initState();
    removeJob = RemoveJob();
  }

  Future showToast(String msg) async {
    await Fluttertoast.cancel();
    Fluttertoast.showToast(msg: msg, fontSize: 18);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        label: widget.job.title,
        actions: [
          TextButton(
            onPressed: () async {
              String title = widget.job.title;
              await removeJob(jobId: widget.job.id).then(
                (value) async {
                  await showToast('Job Named $title Removed Successfully!')
                      .then(
                    (value) => Navigator.pop(context),
                  );
                },
              );
            },
            child: const Padding(
              padding: EdgeInsets.only(right: 10),
              child: Text(
                'Delete',
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
            ),
          )
        ],
        leading: true,
      ),
      body: SlidBarLayout(job: widget.job),
    );
  }
}

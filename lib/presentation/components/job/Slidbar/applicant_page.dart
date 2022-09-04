import 'package:flutter/material.dart';

import '../../../../domain/entities/job/applied/applied_job.dart';
import '../../../../domain/entities/job/job.dart';
import '../../../../domain/usecases/job/applied/accept_applied.dart';
import '../../../../domain/usecases/job/applied/fetch_more.dart';
import '../../../../domain/usecases/job/applied/reject_applied.dart';
import '../applied_job.dart';

class ApplicantPage extends StatefulWidget {
  const ApplicantPage({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  State<ApplicantPage> createState() => _ApplicantPageState();
}

class _ApplicantPageState extends State<ApplicantPage>
    with SingleTickerProviderStateMixin<ApplicantPage> {
  late Job job;
  late List<AppliedJob> ajob;
  late bool allLoaded;
  late bool isLoading;
  late FetchMoreApplied fetchMoreApplied;
  late bool isOpened, isOpening;
  late Duration animationDuration;
  late AnimationController animationController;
  late AcceptApplied acceptApplied;
  late RejectApplied rejectApplied;

  @override
  void initState() {
    super.initState();
    isOpened = false;
    isOpening = false;
    animationDuration = const Duration(milliseconds: 500);
    animationController = AnimationController(
      vsync: this,
      duration: animationDuration,
    );
    allLoaded = false;
    isLoading = false;
    job = widget.job;
    acceptApplied = AcceptApplied(jobId: job.id);
    rejectApplied = RejectApplied(jobId: job.id);
    ajob = [];
    fetchMoreApplied = FetchMoreApplied(jobId: widget.job.id);
    getAppliedJobs();
  }

  getAppliedJobs() async {
    if (allLoaded || isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final List<AppliedJob> tmpAJob = await fetchMoreApplied(limit: 10);
    setState(() {
      allLoaded = tmpAJob.length < 10;
      ajob = tmpAJob;
      isLoading = false;
    });
  }

  @override
  dispose() {
    super.dispose();
    animationController.dispose();
  }

  onIconPressed() async {
    setState(() {
      isOpening = true;
      isOpened = true ^ isOpened;
    });
    await Future.delayed(const Duration(milliseconds: 500)).then((value) {
      setState(() {
        isOpening = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final BoxDecoration boxDecoration = BoxDecoration(
      borderRadius: const BorderRadius.only(
        topLeft: Radius.elliptical(40, 20),
        bottomLeft: Radius.elliptical(40, 20),
      ),
      color: Theme.of(context).primaryColor,
      border: Border.all(
        color: Theme.of(context).primaryColor,
        width: 0,
      ),
    );
    final size = MediaQuery.of(context).size;
    return AnimatedPositioned(
      duration: animationDuration,
      top: 0,
      bottom: 0,
      left: isOpened ? 0 : size.width - 35,
      right: isOpened ? 0 : 0,
      child: Row(
        children: [
          Align(
            alignment: const Alignment(0, 0.8),
            child: GestureDetector(
              onTap: () {
                onIconPressed();
              },
              onHorizontalDragStart: (value) {
                onIconPressed();
              },
              child: Container(
                decoration: boxDecoration,
                width: 35,
                height: 110,
                alignment: Alignment.center,
                child: AnimatedIcon(
                  progress: animationController.view,
                  icon: AnimatedIcons.menu_close,
                  color: Colors.white,
                  size: 25,
                ),
              ),
            ),
          ),
          Expanded(
            child: (isOpened && !isOpening)
                ? Container(
                    padding: const EdgeInsets.all(15),
                    alignment: Alignment.center,
                    decoration: boxDecoration,
                    child: ListView(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Text(
                                'Applicants',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 26,
                                ),
                              ),
                            ],
                          ),
                        ),
                        ListView.separated(
                          primary: false,
                          shrinkWrap: true,
                          itemBuilder: (context, index) => AppliedJobWidget(
                            ajob: ajob[index],
                            index: index,
                            callAccDial: (idx) {
                              setState(() {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      actions: [
                                        ElevatedButton(
                                          onPressed: () {
                                            acceptApplied(
                                                appliedJob: ajob[idx]);
                                            // handleRefresh();
                                          },
                                          child: const Text('Accept'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                      ],
                                      title: const Text('Really ?!'),
                                    );
                                  },
                                );
                              });
                            },
                            callRejDial: (idx) {
                              setState(() {
                                AlertDialog(
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        rejectApplied(
                                          appliedId: ajob[idx].appliedId,
                                          // handleRefresh();
                                        );
                                      },
                                      child: const Text('Accept'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: const Text('Cancel'),
                                    ),
                                  ],
                                  title: const Text('Really ?!'),
                                );
                              });
                            },
                          ),
                          separatorBuilder: (context, index) =>
                              const SizedBox(height: 20),
                          itemCount: ajob.length,
                        ),
                      ],
                    ),
                  )
                : Container(decoration: boxDecoration),
          ),
        ],
      ),
    );
  }
}

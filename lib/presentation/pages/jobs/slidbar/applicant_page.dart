import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../domain/entities/job/applied/applied_job.dart';
import '../../../../domain/entities/job/job.dart';
import '../../../../domain/usecases/job/applied/accept_applied.dart';
import '../../../../domain/usecases/job/applied/fetch_more.dart';
import '../../../../domain/usecases/job/applied/reject_applied.dart';
import '../../../components/dialog_button.dart';
import '../../../components/job/applied_job.dart';

class ApplicantPage extends StatefulWidget {
  const ApplicantPage({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  State<ApplicantPage> createState() => _ApplicantPageState();
}

class _ApplicantPageState extends State<ApplicantPage>
    with SingleTickerProviderStateMixin<ApplicantPage> {
  final GlobalKey<LiquidPullToRefreshState> refreshIndicatorKey = GlobalKey();
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
    print(job.id);
    acceptApplied = AcceptApplied(jobId: job.id);
    rejectApplied = RejectApplied(jobId: job.id);
    ajob = [];
    fetchMoreApplied = FetchMoreApplied(jobId: widget.job.id);
    getAppliedJobs();
  }

  Future<void> handleRefresh() async {
    ajob.clear();
    allLoaded = false;
    fetchMoreApplied.refresh();
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
                ? LiquidPullToRefresh(
                    color: Theme.of(context).primaryColor.withOpacity(0.6),
                    showChildOpacityTransition: false,
                    backgroundColor: Theme.of(context).primaryColor,
                    height: 200,
                    springAnimationDurationInMilliseconds: 300,
                    onRefresh: handleRefresh,
                    key: refreshIndicatorKey,
                    child: Container(
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
                              refresh: handleRefresh,
                              ajob: ajob[index],
                              index: index,
                              callAccDial: (idx) {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      contentPadding: const EdgeInsets.all(0),
                                      actionsPadding: const EdgeInsets.all(0),
                                      buttonPadding: const EdgeInsets.all(0),
                                      actions: [
                                        DialogButton(
                                          onPress: () async {
                                            await acceptApplied(
                                              appliedJob: ajob[idx],
                                            ).then(
                                              (value) {
                                                Navigator.pop(context);
                                                handleRefresh();
                                              },
                                            );
                                          },
                                          text: 'Accept',
                                        ),
                                        DialogButton(
                                          onPress: () => Navigator.pop(context),
                                          text: 'Cancel',
                                        ),
                                      ],
                                      title: const Text(
                                        'Are you sure about '
                                        'Accepting this Applicant ?!',
                                      ),
                                    ),
                                  );
                                });
                              },
                              callRejDial: (idx) {
                                setState(() {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      contentPadding: const EdgeInsets.all(20),
                                      actionsPadding: const EdgeInsets.all(10),
                                      buttonPadding: const EdgeInsets.all(10),
                                      actions: [
                                        DialogButton(
                                          onPress: () async {
                                            await rejectApplied(
                                              appliedId: ajob[idx].appliedId,
                                            ).then(
                                              (value) {
                                                Navigator.pop(context);
                                                handleRefresh();
                                              },
                                            );
                                          },
                                          text: 'Reject',
                                        ),
                                        DialogButton(
                                          onPress: () => Navigator.pop(context),
                                          text: 'Cancel',
                                        ),
                                      ],
                                      title: const Text(
                                          'once u do this u cant un do it ?!'),
                                    ),
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
                    ),
                  )
                : Container(decoration: boxDecoration),
          ),
        ],
      ),
    );
  }
}

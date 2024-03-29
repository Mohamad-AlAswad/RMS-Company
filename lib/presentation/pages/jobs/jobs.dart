import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../domain/entities/job/job.dart';
import '../../../domain/usecases/job/fetch_more.dart';
import '../../../domain/usecases/job/pause_status_job.dart';
import '../../../domain/usecases/job/resume_status_job.dart';
import '../../components/components.dart';
import 'add_new_job.dart';

// ignore: must_be_immutable
class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  final GlobalKey<LiquidPullToRefreshState> _refreshIndicatorKey = GlobalKey();
  FetchMoreJob fetchMoreJob = FetchMoreJob();
  late List<Job> allJobs;
  bool isLoading = false;
  late List<bool> value;

  Future<void> _handleRefresh() async {
    _refreshIndicatorKey.currentState?.show();
    allJobs.clear();
    fetchMoreJob.refresh();
    getJobs();
  }

  getJobs() async {
    setState(() {
      isLoading = true;
    });

    List<Job> jobs = await fetchMoreJob(limit: 1000);
    setState(() {
      allJobs = jobs;
    });

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _refreshIndicatorKey.currentState?.show();
    getJobs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: CustomeAppBar(
        label: 'Job Offers',
      ),
      body: Center(
        child: LiquidPullToRefresh(
          key: _refreshIndicatorKey,
          onRefresh: _handleRefresh,
          color: Theme.of(context).primaryColor.withAlpha(200),
          height: 200,
          springAnimationDurationInMilliseconds: 300,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return ListView.separated(
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 10),
                itemCount: isLoading ? 1 : allJobs.length,
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                itemBuilder: (context, index) {
                  if (isLoading) {
                    return Padding(
                      padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.4,
                      ),
                      child: SpinKitFoldingCube(
                        color: Theme.of(context).primaryColor,
                        size: 100,
                      ),
                    );
                  } else {
                    return JobOfferWidget(
                      job: allJobs[index],
                      value: allJobs[index].status,
                      valueChanged: (val) async {
                        List<String> done;
                        if (val == 'running') {
                          done =
                              await ResumeStatusJob()(jobId: allJobs[index].id);
                        } else {
                          done =
                              await PauseStatusJob()(jobId: allJobs[index].id);
                        }
                        if (done.isEmpty) {
                          _handleRefresh();
                        }
                      },
                    );
                  }
                },
              );
            },
          ),
        ),
      ),
      floatingActionButton: SpeedDial(
        backgroundColor: Theme.of(context).primaryColor,
        child: IconButton(
          padding: const EdgeInsets.all(0),
          icon: const Icon(
            Icons.add_circle_outline,
            size: 40,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const AddNewJobPage(),
              ),
            );
          },
        ),
      ),
    );
  }
}

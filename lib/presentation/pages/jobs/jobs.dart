import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:rms_company/domain/usecases/job/fetch_more.dart';
import 'package:rms_company/domain/usecases/job/pause_status_job.dart';
import 'package:rms_company/domain/usecases/job/resume_status_job.dart';
import 'package:rms_company/presentation/components/job/job_offer_widget.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../../data/repositories/job/job_repo_imp.dart';
import '../../../domain/entities/job/job.dart';
import '../../../injection_container.dart';
import '../../components/components.dart';

// ignore: must_be_immutable
class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  FetchMoreJob fetchMoreJob = FetchMoreJob();
  late List<Job> allJobs;
  bool isLoading = false;

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
        child: ListView.builder(
          itemCount: isLoading ? 1 : allJobs.length,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                valueChanged: (val) {
                  setState(
                    () {
                      if (val == 'running') {
                        ResumeStatusJob(
                          jobRepo: JobRepoImp(
                            firebaseFirestore: sl(),
                            authenticationRepo: sl(),
                          ),
                        )(jobId: allJobs[index].id);
                      } else {
                        PauseStatusJob(
                          jobRepo: JobRepoImp(
                            firebaseFirestore: sl(),
                            authenticationRepo: sl(),
                          ),
                        )(jobId: allJobs[index].id);
                      }
                    },
                  );
                },
              );
            }
          },
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
                builder: (_) => const Text('Add Job Page'),
              ),
            );
          },
        ),
      ),
    );
  }
}

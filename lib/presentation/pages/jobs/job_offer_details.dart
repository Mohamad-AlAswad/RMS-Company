import 'package:flutter/material.dart';
import 'package:rms_company/domain/entities/entities.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';
import 'package:rms_company/domain/usecases/job/applied/fetch_more.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

import '../../components/components.dart';

class JobOfferDetails extends StatefulWidget {
  const JobOfferDetails({Key? key, required this.job}) : super(key: key);

  final Job job;

  @override
  State<JobOfferDetails> createState() => _JobOfferDetailsState();
}

class _JobOfferDetailsState extends State<JobOfferDetails> {
  late Job job;
  late List<AppliedJob> ajob;
  late bool allLoaded;
  late bool isLoading;

  @override
  void initState() {
    super.initState();
    allLoaded = false;
    isLoading = false;
    job = widget.job;
    getAppliedJobs();
  }

  getAppliedJobs() async {
    if (allLoaded || isLoading) {
      return;
    }
    setState(() {
      isLoading = true;
    });
    final List<AppliedJob> tmpAJob =
        await FetchMoreApplied(jobId: job.id)(limit: 10);
    setState(() {
      allLoaded = tmpAJob.length < 10;
      isLoading = false;
    });
  }

  final pages = [
    const Page1(),
    const Page1(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomeAppBar(
        label: job.title,
        actions: [TextButton(onPressed: () {}, child: const Text('Delete'))],
        leading: true,
      ),
      body: Stack(
        children: [Page1(), Page2()],
      ),
    );
  }
}

class Page1 extends StatefulWidget {
  const Page1({Key? key}) : super(key: key);

  @override
  State<Page1> createState() => _Page1State();
}

class _Page1State extends State<Page1> {
  int x = 0;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).scaffoldBackgroundColor,
        child: Column(
          children: [
            Container(
              child: Text(x.toString()),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  x++;
                });
              },
              child: const Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatefulWidget {
  const Page2({Key? key}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  int x = 1;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.only(
          left: MediaQuery.of(context).size.width * 0.05 * x,
        ),
        width: MediaQuery.of(context).size.width,
        color: Theme.of(context).primaryColor,
        child: Column(
          children: [
            Container(
              child: Text(x.toString()),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (x == 1) {
                    x = 19;
                  } else {
                    x = 1;
                  }
                });
              },
              child: const Text('Press Me'),
            ),
          ],
        ),
      ),
    );
  }
}

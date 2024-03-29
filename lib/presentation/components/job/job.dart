import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

import '../../../provider/theme.dart';
import '../my_elevated_button.dart';

export 'costume_expansion_tile.dart';
export 'job_offer_widget.dart';

class JobWidget extends StatelessWidget {
  const JobWidget({
    Key? key,
    // required this.job,
  }) : super(key: key);

  // final EvaluatedJob job;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: CustomTheme.c2.withAlpha(70),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: CustomTheme.c2,
          width: 1,
        ),
      ),
      padding: const EdgeInsets.all(12).copyWith(bottom: 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              TextButton(
                onPressed: () {},
                child: const Text(
                  '',
                  // job.companyName,
                  style: TextStyle(fontSize: 22),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMMMEd().format(
                    DateTime.now(),
                    // job.publishedTime.toDate(),
                  ),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: MyElevatedButton(
              press: () {},
              // text: job.title,
              text: '',
              w: 1,
              color: Theme.of(context).primaryColor.withAlpha(100),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: ReadMoreText(
              '',
              // job.summary,
              trimMode: TrimMode.Line,
              trimLines: 3,
              style: const TextStyle(fontSize: 16),
              lessStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
              ),
              moreStyle: TextStyle(
                color: CustomTheme.c2.withBlue(200).withGreen(200),
                fontSize: 18,
              ),
              trimExpandedText: ' show less',
            ),
          ),
          // CustomExpansionTile(job: job),
          // CustomExpansionTile(),
        ],
      ),
    );
  }
}

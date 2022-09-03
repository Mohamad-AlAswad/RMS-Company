import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rms_company/presentation/components/components.dart';

import '../../../domain/entities/job/job.dart';
import '../../../provider/theme.dart';
import '../my_elevated_button.dart';

class JobOfferWidget extends StatelessWidget {
  const JobOfferWidget({
    Key? key,
    required this.job,
    required this.valueChanged,
  }) : super(key: key);

  final Job job;
  final Function valueChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: CustomeTheme.c2.withAlpha(70),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: CustomeTheme.c2,
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
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const Text('Job Offer Details'),
                    ),
                  );
                },
                child: Text(
                  job.title,
                  style: const TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    overflow: TextOverflow.ellipsis,
                  ),
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
              press: null,
              text: job.summary,
              w: 1,
              h: (job.summary.length / 20) * 0.02,
              color: Theme.of(context).primaryColor.withAlpha(100),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Center(
              child: RoundedDropdownButton(
                color: Theme.of(context).primaryColor,
                valueChanged: valueChanged,
                value: job.status,
                label: 'Job Offer Status',
                list: const ['running', 'paused'],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

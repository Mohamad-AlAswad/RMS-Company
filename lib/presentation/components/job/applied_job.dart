import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:intl/intl.dart';
import 'package:rms_company/domain/entities/job/applied/applied_job.dart';

import '../../../provider/theme.dart';
import '../components.dart';
import '../my_elevated_button.dart';
import 'custome_expantion_tile_applied.dart';

export 'job_offer_widget.dart';
export 'costum_expansion_tile.dart';

class AppliedJobWidget extends StatelessWidget {
  const AppliedJobWidget({
    Key? key,
    required this.ajob,
    required this.index,
    required this.callAccDial,
    required this.callRejDial,
  }) : super(key: key);

  final AppliedJob ajob;
  final int index;
  final Function(int) callAccDial, callRejDial;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(120),
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  DateFormat.yMMMEd().format(ajob.appliedTime.toDate()),
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const Text('Profile of an Applicant'),
                ),
              );
            },
            child: Text(
              ajob.fullName,
              style: const TextStyle(fontSize: 22),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(10),
                child: Text(
                  'Status :',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Text(
                  ajob.state,
                  style: const TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              MyElevatedButton(
                press: () => callAccDial(index),
                text: 'Accept',
                w: 0.5,
                color: Colors.green,
              ),
              MyElevatedButton(
                press: () => callRejDial(index),
                text: 'Reject',
                w: 0.20,
                color: Colors.red,
              ),
            ],
          ),

          Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
            child: ReadMoreText(
              ajob.summary,
              trimMode: TrimMode.Line,
              trimLines: 3,
              style: const TextStyle(fontSize: 18),
              lessStyle: TextStyle(
                color: Theme.of(context).colorScheme.secondary,
                fontSize: 18,
              ),
              moreStyle: TextStyle(
                color: CustomeTheme.c2.withBlue(200).withGreen(200),
                fontSize: 18,
              ),
              trimExpandedText: ' show less',
            ),
          ),
          CustomExpansionTileApplied(job: ajob),
          // CustomExpansionTile(),
        ],
      ),
    );
  }
}

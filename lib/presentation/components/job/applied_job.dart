import 'package:flutter/material.dart';

import '../../../provider/theme.dart';
import 'Slidbar/applied_job_elements/applied_job-elements.dart';
import 'custome_expantion_tile_applied.dart';

export 'costum_expansion_tile.dart';
export 'job_offer_widget.dart';

class AppliedJobWidget extends StatefulWidget {
  const AppliedJobWidget({
    Key? key,
    required this.ajob,
    required this.index,
    required this.callAccDial,
    required this.callRejDial,
    this.refresh,
  }) : super(key: key);

  final AppliedJob ajob;
  final int index;
  final Function(int) callAccDial, callRejDial;
  final Function()? refresh;

  @override
  State<AppliedJobWidget> createState() => _AppliedJobWidgetState();
}

class _AppliedJobWidgetState extends State<AppliedJobWidget> {
  late AppliedJob ajob;
  bool opened = false;

  @override
  void initState() {
    super.initState();
    ajob = widget.ajob;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(120),
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
          DateRow(ajob: ajob),
          ClickableApplicantName(ajob: ajob),
          StatusRow(ajob: ajob),
          ChangeStatusButtonsRow(
            callAccDial: widget.callAccDial,
            index: widget.index,
            callRejDial: widget.callRejDial,
          ),
          ApplicantSummary(ajob: ajob),
          CustomExpansionTileApplied(job: ajob),
          const SizedBox(height: 10),
          if (opened) ...[
            TopRow(
              aJob: ajob,
              refresh: widget.refresh,
              iconOnPress: () {
                setState(() {
                  opened = false;
                });
              },
            ),
          ],
          if (!opened) ...[
            BottomRow(
              iconOnPress: () {
                setState(() {
                  opened = true;
                });
              },
            ),
          ],
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}


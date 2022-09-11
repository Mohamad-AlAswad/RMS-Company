import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';

import '../../../../../provider/theme.dart';
import 'applied_job-elements.dart';

class ApplicantSummary extends StatelessWidget {
  const ApplicantSummary({
    Key? key,
    required this.ajob,
  }) : super(key: key);

  final AppliedJob ajob;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          color: CustomTheme.c2.withBlue(200).withGreen(200),
          fontSize: 18,
        ),
        trimExpandedText: ' show less',
      ),
    );
  }
}

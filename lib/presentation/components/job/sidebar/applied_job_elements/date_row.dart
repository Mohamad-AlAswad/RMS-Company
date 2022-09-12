
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'applied_job-elements.dart';



class DateRow extends StatelessWidget {
  const DateRow({
    Key? key,
    required this.ajob,
  }) : super(key: key);

  final AppliedJob ajob;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

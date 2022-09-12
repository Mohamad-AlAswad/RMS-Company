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
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        IconButton(
          onPressed: () {
            throw UnimplementedError();

          },
          tooltip: 'Download CV',
          icon: Icon(
            Icons.download,
            color: Theme.of(context).primaryColor,
            size: 20,
            shadows: [
              Shadow(
                color: Theme.of(context).primaryColor,
                offset: const Offset(0, 0),
                blurRadius: 20,
              ),
            ],
          ),
        ),
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

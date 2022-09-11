
import 'package:flutter/material.dart';

import 'applied_job-elements.dart';


class StatusRow extends StatelessWidget {
  const StatusRow({
    Key? key,
    required this.ajob,
  }) : super(key: key);

  final AppliedJob ajob;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

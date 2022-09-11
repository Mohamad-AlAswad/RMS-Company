import 'package:flutter/material.dart';

import 'applied_job-elements.dart';


class ClickableApplicantName extends StatelessWidget {
  const ClickableApplicantName({
    Key? key,
    required this.ajob,
  }) : super(key: key);

  final AppliedJob ajob;

  @override
  Widget build(BuildContext context) {
    return TextButton(
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
    );
  }
}

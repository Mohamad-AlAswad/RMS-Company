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
      onPressed: () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.6,
            child: Text(
              ajob.fullName,
              style: const TextStyle(
                fontSize: 22,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Text(
            '${ajob.score.truncate()}%',
            style: const TextStyle(fontSize: 22),
          ),
        ],
      ),
    );
  }
}

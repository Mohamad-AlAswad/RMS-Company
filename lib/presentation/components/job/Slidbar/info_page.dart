import 'package:flutter/material.dart';

import '../../../../domain/entities/job/job.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key, required this.job}) : super(key: key);
  final Job job;
  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Center(
        child: Text(
          'Info',
          style: TextStyle(fontSize: 30),
        ),
      ),
    );
  }
}

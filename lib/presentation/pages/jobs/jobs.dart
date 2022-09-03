import 'package:flutter/material.dart';

import '../../components/components.dart';

// ignore: must_be_immutable
class Jobs extends StatefulWidget {
  const Jobs({Key? key}) : super(key: key);

  @override
  State<Jobs> createState() => _JobsState();
}

class _JobsState extends State<Jobs> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,

      appBar: CustomeAppBar(
        label: 'Job Offers',
      ),
      body: const Center(
        child: Text(
          'Your Company Jobs Offer',
        ),
      )
    );
  }
}

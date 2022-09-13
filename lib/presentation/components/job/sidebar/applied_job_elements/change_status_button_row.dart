import 'package:flutter/material.dart';

import '../../../components.dart';

class ChangeStatusButtonsRow extends StatelessWidget {
  const ChangeStatusButtonsRow({
    Key? key,
    required this.callAccDial,
    required this.index,
    required this.callRejDial,
  }) : super(key: key);

  final Function(int p1) callAccDial;
  final int index;
  final Function(int p1) callRejDial;

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}

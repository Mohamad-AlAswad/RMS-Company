
import 'package:flutter/material.dart';

import 'applied_job-elements.dart';

class BottomRow extends StatelessWidget {
  const BottomRow({
    Key? key,
    this.iconOnPress,
  }) : super(key: key);

  final Function()? iconOnPress;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: iconOnPress,
          tooltip: 'Rate Application',
          icon: Icon(
            Icons.stars_rounded,
            size: 35,
            shadows: [
              Shadow(
                color: Theme.of(context).primaryColor,
                blurRadius: 20,
                offset: const Offset(0, 0),
              )
            ],
          ),
          color: Colors.yellow,
        ),
        const Spacer(flex: 5),
        const ShowNotesButton(),
        const Spacer(flex: 1),
        const AddNoteButton(),
      ],
    );
  }
}

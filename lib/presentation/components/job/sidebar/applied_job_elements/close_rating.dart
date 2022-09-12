import 'package:flutter/material.dart';

class CloseRating extends StatelessWidget {
  const CloseRating({
    Key? key,
    this.onPress,
  }) : super(key: key);

  final Function()? onPress;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPress,
      icon: const Icon(
        Icons.save,
        size: 35,
      ),
      color: Theme.of(context).primaryColor,
    );
  }
}

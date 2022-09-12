import 'package:flutter/material.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    Key? key,
    required this.onPressed,
  }) : super(key: key);
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: onPressed,
        child: const Text(
          'add a note',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

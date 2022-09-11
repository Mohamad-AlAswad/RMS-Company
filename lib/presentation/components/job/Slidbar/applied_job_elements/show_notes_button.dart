import 'package:flutter/material.dart';

class ShowNotesButton extends StatelessWidget {
  const ShowNotesButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.30,
      height: MediaQuery.of(context).size.height * 0.06,
      child: TextButton(
        onPressed: () {},
        child: const Text(
          'show notes',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}

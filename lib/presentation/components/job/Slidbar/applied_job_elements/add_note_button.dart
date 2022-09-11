import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddNoteButton extends StatelessWidget {
  const AddNoteButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.25,
      height: MediaQuery.of(context).size.height * 0.06,
      child: ElevatedButton(
        onPressed: () {
          Fluttertoast.cancel();
          Fluttertoast.showToast(msg: 'hello');
        },
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

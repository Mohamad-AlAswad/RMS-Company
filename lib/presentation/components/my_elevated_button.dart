import 'package:flutter/material.dart';

import '../../provider/theme.dart';

// ignore: must_be_immutable
class MyElevatedButton extends StatelessWidget {
  MyElevatedButton({
    Key? key,
    required this.text,
    required this.press,
    this.color = CustomTheme.c1,
    this.textColor = Colors.white,
    this.h = 0.05,
    this.w = 0.5,
  }) : super(key: key);

  final String text;
  final Function()? press;
  final Color color;
  Color newColor = CustomTheme.c2;
  final Color textColor;
  final double w, h;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    newColor = color == CustomTheme.c1
        ? Theme.of(context).primaryColor
        : newColor = color;

    return ElevatedButton(
      style: color != CustomTheme.c1
          ? ButtonStyle(
              textStyle: MaterialStateProperty.resolveWith<TextStyle?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return const TextStyle(
                      color: Colors.grey,
                    );
                  }
                  return null;
                },
              ),
              backgroundColor: MaterialStateProperty.resolveWith(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.pressed)) {
                    return newColor.withAlpha(200);
                  }
                  if (states.contains(MaterialState.disabled)) {
                    return newColor.withAlpha(100);
                  }
                  return newColor;
                },
              ),
              foregroundColor: MaterialStateProperty.all(textColor),
            )
          : null,
      onPressed: press,
      child: SizedBox(
        width: size.width * w,
        height: size.height * h,
        child: Center(
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}

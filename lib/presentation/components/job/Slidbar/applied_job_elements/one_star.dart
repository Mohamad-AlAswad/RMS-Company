
import 'package:flutter/material.dart';

class OneStar extends StatefulWidget {
  OneStar({
    Key? key,
    this.onPress,
    this.iconData = Icons.star,
    this.flag = false,
  })  : starState = _OneStarState(),
        super(key: key);

  // ignore: library_private_types_in_public_api
  final _OneStarState starState;
  final Function()? onPress;
  final IconData iconData;
  final bool flag;

  @override
  // ignore: no_logic_in_create_state
  State<OneStar> createState() => starState;
}

class _OneStarState extends State<OneStar> {
  late bool filled;

  changeFlag(bool value) {
    setState(() {
      filled = value;
    });
  }

  @override
  void initState() {
    super.initState();
    filled = widget.flag;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.1,
      child: IconButton(
        onPressed: widget.onPress,
        icon: Icon(
          widget.iconData != Icons.star
              ? widget.iconData
              : filled
              ? Icons.star
              : Icons.star_border_outlined,
          size: 30,
          shadows: [
            Shadow(
              color: Theme.of(context).primaryColor,
              offset: const Offset(0, 0),
              blurRadius: 30,
            ),
          ],
        ),
        color: Colors.yellow,
      ),
    );
  }
}

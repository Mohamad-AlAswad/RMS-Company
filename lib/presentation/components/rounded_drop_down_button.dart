
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class RoundedDropdownButton extends StatefulWidget {
  const RoundedDropdownButton({
    Key? key,
    required this.color,
    required this.valueChanged,
    this.value,
    this.icon = Icons.person,
    this.secColor = Colors.white,
    this.hintText = 'input here',
    this.label = '',
    this.enabled = true,
    this.list,
    this.w = 0.7,
    this.h = 0.06,
    this.onRefresh,
  }) : super(key: key);
  final List<String>? list;
  final IconData icon;
  final Color secColor, color;
  final String hintText;
  final double w, h;
  final String label;
  final bool enabled;
  final Function valueChanged;
  final String? value;
  final List<String>?Function()? onRefresh;
  @override
  State<RoundedDropdownButton> createState() => _RoundedDropdownButtonState();
}

class _RoundedDropdownButtonState extends State<RoundedDropdownButton> {
  List<DropdownMenuItem<String>> newList = [];
  List<String>? list;
  String? value;
  @override
  void initState() {
    super.initState();
    list = widget.list;
    value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    if (widget.list != null) {
      newList = list!
          .map(
            (e) => DropdownMenuItem<String>(
              value: e,
              child: Text(e),
            ),
          )
          .toList();
    }
    print(value);
    return Container(
      decoration: BoxDecoration(
        color: (value == 'paused') ? Colors.red : widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 15),
      width: size.width * widget.w,
      height: size.height * widget.h,
      child: Material(
        elevation: 20.0,
        color: (value == 'paused') ? Colors.red : widget.color,
        shadowColor: (value == 'paused') ? Colors.red : widget.color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: DropdownButtonFormField<String>(
          value: value,
          dropdownColor: Colors.white,
          items: newList,
          icon: const Icon(Icons.keyboard_arrow_down_outlined),
          onChanged: (widget.enabled)
              ? (String? val) {
                  widget.valueChanged(val);
                }
              : null,
          autofocus: false,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: const BorderSide(
                width: 0,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 3.0,
              ),
            ),
            enabled: widget.enabled,
            label: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(widget.label),
            ),
            floatingLabelStyle: const TextStyle(
              fontSize: 22,
              backgroundColor: Colors.white,
              color: Colors.black,
            ),
            labelStyle: const TextStyle(
              color: Colors.black,
              fontSize: 22,
            ),
            icon: IconButton(
              icon: Icon(widget.icon, color: widget.secColor),
              onPressed: (widget.onRefresh!=null)?(){
                setState(() {
                  list = widget.onRefresh!();
                  newList = list!
                      .map(
                        (e) => DropdownMenuItem<String>(
                      value: e,
                      child: Text(e),
                    ),
                  )
                      .toList();
                  if(list!.isNotEmpty){
                    value = list![0];
                  }
                  else {
                    value = null;
                  }
                });
              }:null,
            ),
            hintText: widget.hintText,
            fillColor: widget.secColor,
            hintStyle: const TextStyle(color: Colors.black),
            filled: true,
            contentPadding: const EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),
      ),
    );
  }
}

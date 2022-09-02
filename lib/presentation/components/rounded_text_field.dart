import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RoundedTextField extends StatelessWidget {
  const RoundedTextField({
    Key? key,
    required this.controller,
    this.pass = false,
    this.email = false,
    this.code = false,
    this.numbers = false,
    this.isDouble = false,
    this.phone = false,
    this.icon = Icons.ac_unit,
    required this.color,
    this.secColor = Colors.white,
    this.hintText = 'input here',
    this.label = '',
    this.enabled = true,
    this.w = 0.7,
    this.h = 0.06,
    this.multiLines = false,
  }) : super(key: key);
  final TextEditingController controller;
  final bool pass, email, code, numbers, isDouble, phone;
  final IconData icon;
  final Color secColor, color;
  final String hintText;
  final double w, h;
  final String label;
  final bool enabled;
  final bool multiLines;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
      ),
      padding: const EdgeInsets.only(left: 15),
      width: size.width * w,
      height: (multiLines)?null:size.height * h,
      child: Material(
        elevation: 20.0,
        color: color,
        shadowColor: color,
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        child: TextFormField(
          maxLines: (multiLines)?null:1,
          keyboardType: (email == true)
              ? TextInputType.emailAddress
              : (code == true || numbers == true || isDouble == true)
                  ? TextInputType.number
                  : null,
          inputFormatters: [
            if (phone || code || numbers) ...[
              FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
            ],
            if (code) ...[
              LengthLimitingTextInputFormatter(6),
            ],
            if (phone) ...[
              LengthLimitingTextInputFormatter(10),
            ],
            if (isDouble) ...[
              FilteringTextInputFormatter.allow(RegExp(r'(^\d*\.?\d*)'))
            ]
          ],
          controller: controller,
          obscureText: pass,
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
            enabled: enabled,
            label: Padding(
              padding: const EdgeInsets.all(5),
              child: Text(label),
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
            icon: (icon == Icons.ac_unit) ? null : Icon(icon, color: secColor),
            hintText: hintText,
            fillColor: secColor,
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

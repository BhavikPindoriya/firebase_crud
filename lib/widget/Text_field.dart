import 'package:flutter/material.dart';

class TextFieldd extends StatelessWidget {
  TextFieldd(
      {super.key,
      this.controller,
      this.hinttext,
      this.helpertext,
      this.icon,
      this.obscure = false,
      this.validatee,
      this.keybord,
      TextInputType? keyboard});

  TextEditingController? controller;
  String? hinttext;
  String? helpertext;
  Icon? icon;
  bool obscure;
  String? Function(String?)? validatee;
  final TextInputType? keybord;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscure,
        validator: validatee,
        decoration: InputDecoration(
          hintText: "$hinttext",
          helperText: "$helpertext",
          prefixIcon: icon,
        ));
  }
}

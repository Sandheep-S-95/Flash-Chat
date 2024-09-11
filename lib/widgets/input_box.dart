import 'package:flutter/material.dart';

class InputBox extends StatelessWidget {
  const InputBox({required this.placeholderContent, required this.varStore});
  final String placeholderContent;
  final void Function(String) varStore;

  @override
  Widget build(BuildContext context) {
    final bool passwordOrNot= placeholderContent=="Enter your password" ? true : false;
    final bool emailOrNot=placeholderContent=="Enter your email"? true : false;
    return TextField(
      obscureText: passwordOrNot,
      keyboardType: TextInputType.emailAddress,
      textAlign: TextAlign.center,
      onChanged: varStore,
      decoration: InputDecoration(
        hintText: placeholderContent,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 1.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blueAccent, width: 2.0),
          borderRadius: BorderRadius.all(Radius.circular(32.0)),
        ),
      ),
    );
  }
}

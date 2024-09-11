import 'package:flutter/material.dart';

class TextBox extends StatelessWidget {
  const TextBox({required this.boxColor,required this.content,required this.func});
  final Color boxColor;
  final String content;
  final VoidCallback func;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: boxColor,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: func ,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            content,
            style:TextStyle(color:Colors.white),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';

// ignore: must_be_immutable
class ButtonComponent extends StatelessWidget {
  final String buttontext;
  final Decoration buttonDecoration;
  // ignore: prefer_typing_uninitialized_variables
  var onPressed;

  // ignore: use_key_in_widget_constructors
  ButtonComponent({
    required this.buttontext,
    required this.buttonDecoration,
    required this.onPressed
  });

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 60,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: buttonDecoration,
        child: Center(
          child: Text(
            buttontext,
            style: kTextStyle.copyWith(fontSize: 18.0, color: Colors.white,fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

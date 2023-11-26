import 'package:flutter/material.dart';
import 'package:flutix/globals.dart';

// ignore: must_be_immutable
class ButtonComponent extends StatelessWidget {
  final String buttontext;
  final BoxDecoration buttonDecoration;
  final bool invert;
  // ignore: prefer_typing_uninitialized_variables
  var onPressed;

  // ignore: use_key_in_widget_constructors
  ButtonComponent(
      {required this.buttontext,
      this.buttonDecoration = constButtonDecoration,
      this.invert = false,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
        decoration: buttonDecoration.copyWith(
          color: invert ? Colors.white : constPrimaryColor
        ),
        child: Center(
          child: Text(
            buttontext,
            style: kTextStyle.copyWith(
                fontSize: 21.0,
                color: invert ? constPrimaryColor :Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}

class ButtonIconComponent extends StatelessWidget {
  final String buttontext;
  final BoxDecoration buttonDecoration;
  final IconData icon;
  final bool invert;
  var onPressed;

  // ignore: use_key_in_widget_constructors
  ButtonIconComponent(
      {required this.buttontext,
      this.buttonDecoration = constButtonDecoration,
      this.invert = false,
      this.icon = Icons.arrow_circle_right_rounded,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Container(
        width: double.infinity,
        height: 70,
        padding:
            const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 30, right: 30),
        decoration: buttonDecoration.copyWith(
          color: invert ? Colors.white : constPrimaryColor
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              buttontext,
              style: kTextStyle.copyWith(
                  fontSize: 21.0,
                  color: invert ? constPrimaryColor : Colors.white,
                  fontWeight: FontWeight.bold),
            ),
            Icon(icon, color: invert ? constPrimaryColor : Colors.white, size: 35)
          ],
        ),
      ),
    );
  }
}

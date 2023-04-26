import 'package:flutter/material.dart';
import 'package:rounded_loading_button/rounded_loading_button.dart';

class LoadingButton extends StatelessWidget {
  const LoadingButton({Key? key, required this.controller, required this.onPressed, required this.text}) : super(key: key);
  final RoundedLoadingButtonController controller;
  final void Function() onPressed;
  final String text;
  @override
  Widget build(BuildContext context) {
    return RoundedLoadingButton(
      completionDuration: Duration(seconds: 3),
      resetDuration: Duration(seconds: 3),
      resetAfterDuration: true,
      child: Text(text, style: TextStyle(color: Colors.white)),
      controller: controller,
      onPressed: onPressed,
    );
  }
}

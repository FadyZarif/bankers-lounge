
import 'package:flutter/material.dart';

class DefButton extends StatelessWidget {
  final String text;
  final void Function() onPressed;
  final Color textColor = Colors.white;
  final Color? color;

  const DefButton({Key? key, required this.text, required this.onPressed, this.color}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return  Container(

      height: 50,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(5),
      ),
      child: MaterialButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class TabBarUsers extends StatelessWidget {
  const TabBarUsers({Key? key, required this.text, required this.number}) : super(key: key);
  final String text;
  final int number;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        const SizedBox(width: 5,),
        Container(
            decoration: BoxDecoration(
                color: Colors.grey[350],
                borderRadius: BorderRadius.circular(2)
            ),
            padding: const EdgeInsets.symmetric(horizontal: 7,vertical: 3),
            child: Text('$number')
        )
      ],
    );
  }
}

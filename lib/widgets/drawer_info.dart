import 'package:flutter/material.dart';

class DrawerInfo extends StatelessWidget {
  const DrawerInfo({Key? key, required this.icon, required this.title}) : super(key: key);
  final IconData icon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon,color: Colors.white,size: 16),
        SizedBox(width: 5,),
        Text(title,style: TextStyle(fontSize: 16,color: Colors.white)),
      ],
    );
  }
}

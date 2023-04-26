import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:no_screenshot/no_screenshot.dart';

import '../models/user_model.dart';

String? uId ;
var token ;

UserModel? currentUser;

NoScreenshot noScreenshot = NoScreenshot.instance;
// _noScreenshot.screenshotOff();

void navigateTo(context,widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

void navigateToReplacement(context,widget){
  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>widget));
}

defToast(
    {required String msg,
      Toast? toastLength,
      ToastGravity? gravity,
      int timeInSecForIosWeb = 5,
      Color backgroundColor = Colors.lightBlueAccent,
      Color textColor = Colors.white,
      double fontSize = 16}) {
  Fluttertoast.showToast(
      msg: msg,
      toastLength: toastLength,
      gravity: gravity,
      timeInSecForIosWeb: timeInSecForIosWeb,
      backgroundColor: backgroundColor,
      textColor: textColor,
      fontSize: fontSize);
}
Future<void> defToast2({
  required BuildContext context,
  required String msg,
  required DialogType dialogType

})async{
  await AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    autoHide: const Duration(seconds: 2),
    title: msg,
    dialogType: dialogType,

  ).show();
}

class CenterTransition extends PageRouteBuilder {
  final Widget page;

  CenterTransition(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return Align(
        alignment: Alignment.center,
        child: SizeTransition(
          axis: Axis.horizontal,
          sizeFactor: animation,
          child: page,
          axisAlignment: 0,
        ),
      );
    },
  );
}
class BottomScaleTransition extends PageRouteBuilder {
  final Widget page;

  BottomScaleTransition(this.page)
      : super(
    pageBuilder: (context, animation, anotherAnimation) => page,
    transitionDuration: Duration(milliseconds: 1000),
    reverseTransitionDuration: Duration(milliseconds: 200),
    transitionsBuilder: (context, animation, anotherAnimation, child) {
      animation = CurvedAnimation(
          curve: Curves.fastLinearToSlowEaseIn,
          parent: animation,
          reverseCurve: Curves.fastOutSlowIn);
      return ScaleTransition(
        alignment: Alignment.bottomCenter,
        scale: animation,
        child: child,
      );
    },
  );
}



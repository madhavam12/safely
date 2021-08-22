import 'package:flutter/material.dart';

void showInSnackBar(
    {String value, Color color, int sec = 3, @required BuildContext context}) {
  FocusScope.of(context).requestFocus(new FocusNode());

  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: new Text(
      value,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontSize: 16.0, fontFamily: "WorkSansSemiBold"),
    ),
    backgroundColor: color,
    duration: Duration(seconds: sec),
  ));
}

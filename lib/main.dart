import 'package:flutter/material.dart';

import 'screens/loginScreen.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async/async.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'screens/homeScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:liquid_ui/liquid_ui.dart';

void main() async {
  //checks for connection in background nd shows a toat when not connected
  SimpleConnectionChecker _simpleConnectionChecker = SimpleConnectionChecker()
    ..setLookUpAddress('google.com');

  _simpleConnectionChecker.onConnectionChange.listen((connected) {
    if (!connected) {
      Fluttertoast.showToast(
          msg: "No internet connection, please connect to the internet",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  });
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  if (FirebaseAuth.instance.currentUser != null) {
    runApp(LiquidApp(materialApp: MaterialApp(home: HomeScreen())));
  } else {
    runApp(LiquidApp(materialApp: MaterialApp(home: LoginScreen())));
  }
}

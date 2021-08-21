import 'package:flutter/material.dart';

import 'screens/loginScreen.dart';
import 'package:simple_connection_checker/simple_connection_checker.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:async/async.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';

void main() async {
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
  runApp(MaterialApp(home: LoginScreen()));
}

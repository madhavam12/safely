import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safely/models/requestModel.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';

class Firestore {
  final _firestore = FirebaseFirestore.instance;

  List nearbyDeviceTokenList;
  Future<void> writeLoc({@required RequestModel req}) async {
    print('sfas');
    await _firestore.collection('requests').add(req.toJson());
  }
}

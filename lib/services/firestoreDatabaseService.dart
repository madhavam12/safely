import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:safely/models/requestModel.dart';

class Firestore {
  final _firestore = FirebaseFirestore.instance;

  Future<void> writeLoc({@required RequestModel req}) async {
    await _firestore.collection('requests').add(req.toJson());
  }
}

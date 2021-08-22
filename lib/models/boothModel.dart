import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class BoothModel {
  final String name;

  final String deviceToken;
  final String userId;
  final String phone;
  final String address;
  Timestamp timestamp;
  final Map loc;

  BoothModel({
    @required this.deviceToken,
    @required this.address,
    @required this.phone,
    @required this.name,
    @required this.userId,
    @required this.loc,
  });

  BoothModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        userId = json['uid'],
        phone = json['phone'],
        address = json['address'],
        deviceToken = json["token"],
        timestamp = json['timeStamp'],
        loc = json['loc'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'loc': loc,
        'address': address,
        "phone": phone,
        "token": deviceToken,
        'uid': userId,
        'timeStamp': Timestamp.now(),
      };
}

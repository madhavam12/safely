import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class RequestModel {
  final String name;

  final List deviceTokensNearby;
  final List nearbyUsersUIDs;
  final List nearbyUsersNumbers;
  final String userId;

  final String address;
  Timestamp timestamp;
  final Map loc;

  RequestModel({
    @required this.deviceTokensNearby,
    @required this.address,
    @required this.nearbyUsersNumbers,
    @required this.nearbyUsersUIDs,
    @required this.name,
    @required this.userId,
    @required this.loc,
  });

  RequestModel.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        userId = json['userId'],
        nearbyUsersNumbers = json['nearbyUsersNumbers'],
        address = json['address'],
        nearbyUsersUIDs = json['nearbyUsersUID'],
        deviceTokensNearby = json["deviceTokensNearby"],
        timestamp = json['timeStamp'],
        loc = json['loc'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'loc': loc,
        "nearbyUsersNumbers": nearbyUsersNumbers,
        'nearbyUsersUID': nearbyUsersUIDs,
        'address': address,
        "deviceTokensNearby": deviceTokensNearby,
        'userId': userId,
        'timeStamp': Timestamp.now(),
      };
}

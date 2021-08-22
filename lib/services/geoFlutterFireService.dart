import 'package:geolocator/geolocator.dart';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safely/models/requestModel.dart';

import 'firestoreDatabaseService.dart';
import 'package:geocoder/geocoder.dart' as coder;

import 'package:cloud_firestore/cloud_firestore.dart';

class GeoFire {
  //create an object of geoflutterfire
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance; //instance of firestore

  Stream<List<DocumentSnapshot>>
      stream; //stream which yields nearby booth documents

  Future<Stream> triggerBoothsStream() async {
    Position pos = await _determinePosition();
    GeoFirePoint center =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);

    var collectionReference =
        _firestore.collection('pinkBooths'); //collection name
    double radius = 5; //5KM radius
    String field = 'loc';
    stream = geo.collection(collectionRef: collectionReference).within(
        center: center,
        radius: radius,
        field: field); //yields the list of documents within a 5KM radius

    return stream;
  }

//below function writes geolocation data to firestore
  writeGeoPoint({
    @required List<String> tokens,
    @required List<String> numbers,
    @required List<String> nearbyUsersUIDs,
  }) async {
    try {
      Position pos = await _determinePosition();
      Firestore db = Firestore();

      String address = await _getLocalityName(pos);

      GeoFirePoint loc =
          geo.point(latitude: pos.latitude, longitude: pos.longitude);

      await db.writeLoc(
        req: RequestModel(
            photoURL: FirebaseAuth.instance.currentUser.photoURL,
            nearbyUsersNumbers: numbers,
            nearbyUsersUIDs: nearbyUsersUIDs,
            deviceTokensNearby: tokens,
            address: address,
            name: FirebaseAuth.instance.currentUser.displayName,
            userId: FirebaseAuth.instance.currentUser.uid,
            loc: loc.data),
      );
    } catch (e) {
      print(e);
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      return e;
    }
  }

//get addressline from lat and long
  _getLocalityName(Position pos) async {
    final coordinates = coder.Coordinates(pos.latitude, pos.longitude);
    var addresses =
        await coder.Geocoder.local.findAddressesFromCoordinates(coordinates);

    return addresses.first.addressLine;
  }

//request and determine position
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }
}

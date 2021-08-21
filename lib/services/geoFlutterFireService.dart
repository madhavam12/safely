import 'package:geolocator/geolocator.dart';

import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:safely/models/requestModel.dart';

import 'firestoreDatabaseService.dart';
import 'package:geocoder/geocoder.dart' as coder;

class GeoFire {
  final geo = Geoflutterfire();

  writeGeoPoint() async {
    try {
      Position pos = await _determinePosition();
      String address = await _getLocalityName(pos);

      GeoFirePoint loc =
          geo.point(latitude: pos.latitude, longitude: pos.longitude);

      Firestore db = Firestore();
      await db.writeLoc(
        req: RequestModel(
            address: address,
            name: FirebaseAuth.instance.currentUser.displayName,
            userId: FirebaseAuth.instance.currentUser.uid,
            loc: loc.data),
      );
    } catch (e) {
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

  _getLocalityName(Position pos) async {
    final coordinates = coder.Coordinates(pos.latitude, pos.longitude);
    var addresses =
        await coder.Geocoder.local.findAddressesFromCoordinates(coordinates);

    return addresses.first.addressLine;
  }

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

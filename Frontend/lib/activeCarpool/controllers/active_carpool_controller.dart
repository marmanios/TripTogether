import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

String? _carpoolID;
String? _offererID;

class ActiveCarpoolController {
  static final db = FirebaseFirestore.instance;

  static void setData({
    required carpoolID,
    required offererID,
  }) {
    _carpoolID = carpoolID;
    _offererID = offererID;
  }

  static String getCarpoolID() {
    return _carpoolID!;
  }

  static Future<Map<String, dynamic>?> getCarpoolData() async {
    final snapshot = await db.collection('offers').doc(_carpoolID).get();
    final carpoolData = snapshot.data();
    return carpoolData;
  }

  static void findRequests(String uid) {}

  static Future<bool> acceptRequest(String carpoolID, String uid) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("requests/$carpoolID");

    //Check if request wasnt cancelled
    ref.child(uid).get().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        final snapshot = await db.collection("offers").doc(carpoolID).get();
        Map<String, dynamic>? data = snapshot.data();
        List<dynamic> _newPassengers = data!["passengers"];
        _newPassengers.add(uid);
        //print(data.toString());
        // final passengers = snapshot.data()!["passengers"];
        db
            .collection("offers")
            .doc(carpoolID)
            .update({"passengers": _newPassengers});
        await ref.set({uid: "Accepted"});
        return true;
      } else {
        return false;
      }
    });
    return false;
  }

  static Future<void> declineRequest(String carpoolID, String uid) async {
    DatabaseReference ref =
        FirebaseDatabase.instance.ref("requests/$carpoolID");

    //Check if request wasnt cancelled
    ref.child(uid).get().then((DataSnapshot snapshot) async {
      if (snapshot.value != null) {
        final snapshot = await db.collection("offers").doc(carpoolID).get();
        Map<String, dynamic>? data = snapshot.data();
        await ref.set({uid: "Rejected"});
      } else {}
    });
  }

  static Future<LatLng?> getLatLng(String placeId) async {
    Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json',
        {"place_id": placeId, "key": APIkey});

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final Map<String, dynamic> location =
            data['result']['geometry']['location'];
        return LatLng(location['lat'], location['lng']);
      }
    } catch (e) {
      return null;
    }
  }
}

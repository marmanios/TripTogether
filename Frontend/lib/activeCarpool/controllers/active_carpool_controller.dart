import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
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

  static Future<Map<String, dynamic>?> getCarpoolData() async {
    final snapshot = await db.collection('offers').doc(_carpoolID).get();
    final userData = snapshot.data();
    return userData;
  }

  static void findRequests(String uid) {}

  static void acceptRequest(String uid) {
    //update DB
    //update Controller
    //ping user they in
  }
  static void stringDeclineRequest(String uid) {}

  static void getLatLng(String uid) {
    Future<LatLng?> getPlaceData(String placeId) async {
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
}

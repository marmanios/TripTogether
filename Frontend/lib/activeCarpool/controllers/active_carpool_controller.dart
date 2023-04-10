import 'dart:convert';

import 'package:flutterapp/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;

String? _carpoolID;
String? _offererID;
String? _maxPassengers;
String? _taxiID;
String? _fare;
Map<String, dynamic>? _destination;
Map<String, dynamic>? _stops;
Map<String, dynamic>? _passengers;

class ActiveCarpoolController {
  static void setData(
      {required carpoolID,
      required offererID,
      required maxPassengers,
      required taxiID,
      required fare,
      required destination,
      required stops,
      required passengers}) {
    _carpoolID = carpoolID;
    _offererID = offererID;
    _maxPassengers = maxPassengers;
    _taxiID = taxiID;
    _fare = fare;
    _destination = destination;
    _stops = stops;
    _passengers = passengers;
  }

  static Set<Object?> getData() {
    return ({
      _carpoolID,
      _offererID,
      _maxPassengers,
      _taxiID,
      _fare,
      _destination,
      _stops,
      _passengers,
    });
  }

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

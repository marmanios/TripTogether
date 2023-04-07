// ignore: file_names
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp/constants.dart';

class PlaceData {
  final String? formattedAddress;
  final String? city;
  PlaceData({this.formattedAddress, this.city});
}

class OfferCarpoolController {
  static final db = FirebaseFirestore.instance;

  static SnackBar generateSnackbar({required String text}) {
    return SnackBar(content: Text(text), backgroundColor: Colors.red);
  }

  static Future<void> submitOffer({
    required BuildContext context,
    required String offererID,
    required int maxPassengers,
    required String startLocationID,
    required String destinationLocationID,
    required String taxiID,
    required bool isFemaleOnly,
  }) async {
    showDialog(
        context: context,
        builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ));

    PlaceData? startData = await getPlaceData(startLocationID);
    PlaceData? destinationData = await getPlaceData(destinationLocationID);
    double fare = await getFare(startData, destinationData);

    try {
      db.collection('offers').add({
        "offererID": offererID,
        "maxPassengers": maxPassengers,
        "taxiID": taxiID,
        "fare": fare,
        "isFemaleOnly": isFemaleOnly,
        "destination": {
          "ID": destinationLocationID,
          "formattedAddress": destinationData!.formattedAddress!,
          "destinationCity": destinationData.city!
        },
        "stops": [
          {
            "ID": startLocationID,
            "formattedAddress": startData!.formattedAddress!,
            "destinationCity": startData.city!
          }
        ],
        
      });
    } catch (e) {}
    //ignore: use_build_context_synchronously
    Navigator.of(context, rootNavigator: true).pop();
  }
}

Future<PlaceData?> getPlaceData(String placeId) async {
  Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json',
      {"place_id": placeId, "key": APIkey});

  try {
    final response = await http.get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> data = jsonDecode(response.body);
      //print(data);
      String? formattedAddress = data['result']['formatted_address'];

      List<dynamic> addressComponents = data['result']['address_components'];
      for (var component in addressComponents) {
        List<dynamic> types = component['types'];
        if (types.contains('locality')) {
          String? city = component['long_name'];
          return PlaceData(formattedAddress: formattedAddress, city: city);
        }
      }
      return null;
    }
  } catch (e) {
    return null;
  }
}

Future<double> getFare(PlaceData? placeOne, PlaceData? placeTwo) async {
  String origin = placeOne!.formattedAddress!;
  String destination = placeTwo!.formattedAddress!;
  String apiKey = APIkey;

  var response = await http.get(Uri.parse(
      'https://maps.googleapis.com/maps/api/distancematrix/json?units=metric&origins=$origin&destinations=$destination&key=$apiKey'));

  Map<String, dynamic> data = jsonDecode(response.body);

  int distance = data['rows'][0]['elements'][0]['distance']['value'];
  double distanceInKm = distance / 1000.0;

  return distanceInKm * taxiRatePerKm + taxiFlatRate;
}

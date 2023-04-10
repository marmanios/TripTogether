// ignore: file_names
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp/constants.dart';
// ignore: depend_on_referenced_packages

class PlaceData {
  final String? formattedAddress;
  final String? city;
  PlaceData({this.formattedAddress, this.city});
}

class RequestCarpoolController {
  static final db = FirebaseFirestore.instance;

  static SnackBar generateSnackbar({required String text}) {
    return SnackBar(content: Text(text), backgroundColor: Colors.red);
  }

  static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>>
      getOfferList({
    required BuildContext context,
    required String destinationLocationID,
    required bool isFemaleOnly,
  }) async {
    final collectionRef = FirebaseFirestore.instance.collection('offers');
    final destinationCityName = await getCityName(destinationLocationID);
    // create a query to filter documents where destination == 'town' and limit the results to 10 documents
    // print(destinationCityName);
    // print(isFemaleOnly);
    final querySnapshot = await collectionRef
        .where('destination.destinationCity', isEqualTo: destinationCityName)
        .where('isFemaleOnly', isEqualTo: isFemaleOnly)
        .limit(10)
        .get();
    // print(querySnapshot);
    // for (var element in querySnapshot.docs) {
    //   print(element.data());
    // }

    return querySnapshot.docs;
  }

  static Future<String?> getCityName(String placeId) async {
    Uri uri = Uri.https("maps.googleapis.com", 'maps/api/place/details/json',
        {"place_id": placeId, "key": APIkey});

    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = jsonDecode(response.body);
        List<dynamic> addressComponents = data['result']['address_components'];
        for (var component in addressComponents) {
          List<dynamic> types = component['types'];
          if (types.contains('locality')) {
            String? city = component['long_name'];
            return city;
          }
        }
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}

import 'dart:ffi';
import '../../auth/controllers/user_profile_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/activeCarpool/controllers/active_carpool_controller.dart';
import 'package:flutterapp/activeCarpool/screens/incoming_request_page.dart';
import 'package:flutterapp/common/widgets/custom_InsertStars.dart';
import 'package:flutterapp/common/widgets/custom_activepage_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:firebase_database/firebase_database.dart';
import 'display_fare_page.dart';

import '../../constants.dart';

class ActiveCarpoolPage extends StatefulWidget {
  const ActiveCarpoolPage({Key? key}) : super(key: key);

  @override
  State<ActiveCarpoolPage> createState() => _ActiveCarpoolPageState();
}

class _ActiveCarpoolPageState extends State<ActiveCarpoolPage> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;
  Map<String, dynamic>? carpoolData;
  Map<String, dynamic>? requestPassengerData;
  List<Map<String, dynamic>> passengerDetails = [];
  final carpoolID = ActiveCarpoolController.getCarpoolID();
  final DatabaseReference requestRef = FirebaseDatabase.instance
      .ref("requests/${ActiveCarpoolController.getCarpoolID()}");
  final double fontSize = 20;

  int counter = 0;

  LatLng? _currentPosition;
  String _mapStyle = "";

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/map_style.txt')
        .then((string) => _mapStyle = string);
    _getLocation();
    _getCarpoolData();
    requestRef.onChildAdded
        .listen((DatabaseEvent event) => {_displayRequest(event)});
  }

  void _getCarpoolData() async {
    Map<String, dynamic>? data = await ActiveCarpoolController.getCarpoolData();
    List<Map<String, dynamic>> _passengerDetails = [];
    for (var element in data!["passengers"]) {
      final passengerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(element)
          .get();

      final passengerDetails = passengerSnapshot.data();
      _passengerDetails.add(passengerDetails!);
    }
    //print(data);
    setState(() {
      passengerDetails = _passengerDetails;
      carpoolData = data;
    });
  }

  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      this._currentPosition = location;
    });
  }

  void _updateActiveCarpool(String newPassengerID) async {
    // double _newFare = double.parse(
    //     (carpoolData!["fare"] / (carpoolData!["passengers"].length + 1))
    //         .toStringAsFixed(2));
    final _passengerSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(newPassengerID)
        .get();
    final _passengerDetails = _passengerSnapshot.data();
    setState(() {
      carpoolData!["passengers"].add(newPassengerID);
      //carpoolData!["fare"] = _newFare;
      passengerDetails.add(_passengerDetails!);
    });
  }

  void _displayRequest(DatabaseEvent event) async {
    if (carpoolData!["offererID"] != FirebaseAuth.instance.currentUser!.uid) {
      return null;
    }
    final passengerSnapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(event.snapshot.key)
        .get();
    final requestPassengerData = passengerSnapshot.data();

    // ignore: use_build_context_synchronously
    showDialog(
        context: context,
        builder: (_) => WillPopScope(
            child: AlertDialog(
              title: const Text("Request Received!"),
              content: SizedBox(
                height: 150,
                child: Column(children: [
                  Text(
                    requestPassengerData!["name"],
                    style: const TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                    child:
                        InsertStars(numStars: requestPassengerData!["rating"]),
                  ),
                ]),
              ),
              actions: [
                TextButton(
                    onPressed: () async => {
                          Navigator.of(context).pop(),
                          await ActiveCarpoolController.acceptRequest(
                              carpoolID, event.snapshot.key!),
                          _updateActiveCarpool(event.snapshot.key!)
                        },
                    child: const Text("Accept Request")),
                TextButton(
                    onPressed: () => {
                          Navigator.of(context).pop(),
                          ActiveCarpoolController.declineRequest(
                              carpoolID, event.snapshot.key!)
                        },
                    child: const Text("Deny Request"))
              ],
            ),
            onWillPop: () async {
              return false;
            }),
        barrierDismissible: false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text("Active Carpool"),
              elevation: 1,
              backgroundColor: loginTitleColor,
            ),
            body: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 10,
                  child: GoogleMap(
                    mapType: MapType.normal,
                    myLocationEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (GoogleMapController controller) {
                      mapController = controller;
                      mapController.setMapStyle(_mapStyle);
                    },
                    initialCameraPosition: CameraPosition(
                      target: (_currentPosition == null)
                          ? const LatLng(51.2538, 85.3232)
                          : _currentPosition!,
                      zoom: 16.0,
                    ),
                    markers: _markers.values.toSet(),
                  ),
                ),
                const SizedBox(height: 20),
                carpoolData == null
                    ? Container()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                              minWidth: MediaQuery.of(context).size.width),
                          child: Container(
                            height: 100,
                            color: const Color.fromARGB(255, 202, 217, 225),
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Passengers:",
                                  style: TextStyle(
                                    fontSize: 28,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  color:
                                      const Color.fromARGB(255, 202, 217, 225),
                                  child: Column(children: [
                                    Row(
                                      children: [
                                        for (var passenger in passengerDetails)
                                          Row(
                                            children: [
                                              const Icon(
                                                Icons.account_circle_outlined,
                                                size: 30,
                                              ),
                                              Text(
                                                passenger[
                                                    "name"], //Placeholder name ---------------------------------------------------------------------------------------------------------------
                                                style: TextStyle(
                                                  fontSize: fontSize,
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 120,
                                              ),
                                            ],
                                          ),
                                      ],
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        )),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          "Estimated Fare: ",
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          //Fare Text -----------------------------------------------------------------------------------------------------------
                          "\$${carpoolData!['fare'] / carpoolData!["passengers"].length}",
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Destination: ",
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Flexible(
                            child: Text(
                          carpoolData!["destination"]["formattedAddress"],
                          style: TextStyle(fontSize: 20),
                        ))
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ActiveButton(
                      text: "TuneTogether",
                      textSize: 15,
                      newIcon: Icons.arrow_circle_right,
                      buttoncolor: const Color.fromARGB(255, 1, 64, 17),
                      textColor: const Color.fromARGB(255, 255, 255, 255),
                      width: 250,
                      height: 60,
                      image: 'assets/spotify.png',
                      onTap: () => {UserProfileController.openSpotify(context)},
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    ActiveButton(
                        text: "End Carpool",
                        textSize: 15,
                        newIcon: Icons.arrow_circle_left,
                        buttoncolor: const Color.fromARGB(255, 179, 1, 1),
                        textColor: const Color.fromARGB(255, 255, 255, 255),
                        width: 250,
                        height: 60,
                        image: 'assets/cancel.png',
                        onTap: () => {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DisplayFarePage(
                                      fare: carpoolData!["fare"] /
                                          passengerDetails.length,
                                      passengers: passengerDetails),
                                ),
                              )
                            }),
                  ],
                ),
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

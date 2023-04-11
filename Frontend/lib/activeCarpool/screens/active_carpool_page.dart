import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/activeCarpool/controllers/active_carpool_controller.dart';
import 'package:flutterapp/common/widgets/custom_activepage_button.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

import '../../common/widgets/custom_home_button.dart';

class ActiveCarpoolPage extends StatefulWidget {
  const ActiveCarpoolPage({Key? key}):super(key: key);

  @override
  State<ActiveCarpoolPage> createState() => _ActiveCarpoolPageState();
}

class _ActiveCarpoolPageState extends State<ActiveCarpoolPage> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;
  late Map<String, dynamic>? carpoolData;
  late Map<String, dynamic>? passengerData;
  final double fontSize = 20;

  LatLng? _currentPosition;
  bool _isLoading = true;
  String _mapStyle = "";

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/map_style.txt')
        .then((string) => _mapStyle = string);
    _getLocation();
    _getCarpoolData();
  }

  void _getCarpoolData() async {
    Map<String, dynamic>? data = await ActiveCarpoolController.getCarpoolData();
    print(data);
    setState(() {
      this.carpoolData = data;
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
      this._isLoading = false;
    });
  }

  void _getPassengerData() async {}

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: const Text("Active Carpool"),
              elevation: 1,
            ),
            body: Column(
              children: [
                // Text(
                //   //Destination Text -----------------------------------------------------------------------------------------------------------
                //   "Destination: ",
                //   style: TextStyle(
                //     fontSize: 20,
                //   ),
                // ),
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
                SizedBox(height: 20),
                carpoolData == null
                    ? Container()
                    : SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          height: 100,
                          color: Color.fromARGB(255, 202, 217, 225),
                          alignment: Alignment.center,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Passengers:",
                                style: TextStyle(
                                  fontSize: 28,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                color: Color.fromARGB(255, 202, 217, 225),
                                child: Column(children: [
                                  Row(
                                    children: [
                                      for (var i =
                                              0; //Passengers Loop -----------------------------------------------------------------------------------------------------------
                                          i < 7; //This needs to change to the number of passengers currently riding. Since Im assuming the carpool won't always be full.
                                          i++)
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.account_circle_outlined,
                                              size: 30,
                                            ),
                                            Text(
                                              "John Smith", //Placeholder name ---------------------------------------------------------------------------------------------------------------
                                              style: TextStyle(
                                                fontSize: fontSize,
                                              ),
                                            ),
                                            SizedBox(
                                              width: 120,
                                            ),
                                          ],
                                        ),

                                      //IconTextColumns(count: 4),
                                    ],
                                  ),
                                  // Row(
                                  //   children: const [Text("Passengers")],
                                  // ),
                                  // Row(
                                  //   children: const [Text("Passengers")],
                                  // )
                                ]),
                              ),
                            ],
                          ),
                        ),
                      ),

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
                          "\$" + carpoolData!['fare'].toString(),
                          style: TextStyle(
                            fontSize: fontSize,
                          ),
                        ),
                        SizedBox(
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
                        Text(
                          "Placeholder Destination",
                          style: TextStyle(fontSize: 20),
                        )
                      ],
                    )
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Column(
                  children: [
                    ActiveButton(
                      text: "TuneTogether",
                      textSize: 15,
                      newIcon: Icons.arrow_circle_right,
                      buttoncolor: Color.fromARGB(255, 1, 64, 17),
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      width: 250,
                      height: 60,
                      image: 'assets/spotify.png',
                      onTap: () => {},
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ActiveButton(
                      text: "Cancel",
                      textSize: 15,
                      newIcon: Icons.arrow_circle_left,
                      buttoncolor: Color.fromARGB(255, 179, 1, 1),
                      textColor: Color.fromARGB(255, 255, 255, 255),
                      width: 180,
                      height: 60,
                      image: 'assets/cancel.png',
                      onTap: () => {},
                    ),
                  ],
                ),
                // FutureBuilder<void>(
                //   future: ActiveCarpoolController.getCarpoolData(),
                // )
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

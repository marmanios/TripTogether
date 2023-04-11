import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/activeCarpool/controllers/active_carpool_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

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
                carpoolData == null
                    ? Container()
                    : Column(children: [
                        Row(
                          children: [Text(carpoolData!['fare'].toString())],
                        ),
                        Row(
                          children: const [Text("Passengers")],
                        ),
                        Row(
                          children: const [Text("Passengers")],
                        ),
                        Row(
                          children: const [Text("Passengers")],
                        )
                      ])
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

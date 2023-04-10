import 'package:flutter/material.dart';
import 'package:flutterapp/activeCarpool/controllers/active_carpool_controller.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/services.dart' show rootBundle;

class ActiveCarpoolPage extends StatefulWidget {
  const ActiveCarpoolPage({super.key});

  @override
  State<ActiveCarpoolPage> createState() => _ActiveCarpoolPageState();
}

class _ActiveCarpoolPageState extends State<ActiveCarpoolPage> {
  final Map<String, Marker> _markers = {};
  late GoogleMapController mapController;
  LatLng? _currentPosition;
  bool _isLoading = true;
  String _mapStyle = "";

  @override
  void initState() {
    super.initState();
    rootBundle
        .loadString('assets/map_style.txt')
        .then((string) => _mapStyle = string);
    getLocation();
  }

  void getLocation() async {
    LocationPermission permission = await Geolocator.requestPermission();
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    double lat = position.latitude;
    double long = position.longitude;

    LatLng location = LatLng(lat, long);

    setState(() {
      _currentPosition = location;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(ActiveCarpoolController.getData().toString());
    Set<Object?> data = ActiveCarpoolController.getData();
    return WillPopScope(
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              title: Text(ActiveCarpoolController.getData().toString()),
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
                Text(ActiveCarpoolController.getData().toString())
              ],
            ),
          ),
        ),
        onWillPop: () async => false);
  }
}

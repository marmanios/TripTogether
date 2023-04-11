// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import 'package:flutterapp/common/widgets/location_list_tile.dart';
import 'package:flutterapp/offerCarpool/models/response_fetcher.dart';
import 'package:flutterapp/requestCarpool/controllers/request_carpool_controller.dart';
import 'package:flutterapp/requestCarpool/screens/available_offers_page.dart';
import 'package:get/get.dart';
import '../../constants.dart';
import '../../offerCarpool/models/autocomplete_prediction.dart';
import '../../offerCarpool/models/place_auto_complete_response.dart';

User? currentUser = FirebaseAuth.instance.currentUser;

class RequestCarpoolPage extends StatefulWidget {
  const RequestCarpoolPage({Key? key}) : super(key: key);

  @override
  State<RequestCarpoolPage> createState() => _RequestCarpoolPageState();
}

class _RequestCarpoolPageState extends State<RequestCarpoolPage> {
  final TextEditingController _startSearchFieldController =
      TextEditingController();
  final TextEditingController _destinationSearchFieldController =
      TextEditingController();
  final TextEditingController _startPlaceIDController = TextEditingController();
  final TextEditingController _destinationPlaceIDController =
      TextEditingController();
  bool _isFemaleController = false;

  List<AutocompletePrediction> startPlacePredictions = [];
  List<AutocompletePrediction> destinationPlacePredictions = [];

  _RequestCarpoolPageState();

  @override
  void dispose() {
    super.dispose();
    _startSearchFieldController.dispose();
    _destinationSearchFieldController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.white,
          leading: const BackButton(
            color: buttonColor,
          )),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Enter Ride Details",
              style: TextStyle(
                  color: registerTitleColor, fontSize: loginTitleFontSize),
            ),
            TextField(
              style: const TextStyle(color: registerTitleColor),
              controller: _startSearchFieldController,
              onChanged: (value) => {placeAutocomplete(value, true)},
              showCursor: false,
              decoration: const InputDecoration(
                  labelText: 'Pickup Location',
                  labelStyle: TextStyle(
                      color: kTextFieldLabelColor,
                      fontSize: kTextFieldLabelSize),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kTextFieldLine),
                  )),
            ),
            Expanded(
                child: startPlacePredictions.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        itemCount: startPlacePredictions.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => LocationListTile(
                              press: _onSelectStart,
                              location:
                                  startPlacePredictions[index].description!,
                              placeID: startPlacePredictions[index].placeID!,
                            ))),
            TextField(
              style: const TextStyle(color: registerTitleColor),
              showCursor: false,
              onChanged: (value) => {placeAutocomplete(value, false)},
              controller: _destinationSearchFieldController,
              decoration: const InputDecoration(
                  labelText: 'Destination Location',
                  labelStyle: TextStyle(
                      color: kTextFieldLabelColor,
                      fontSize: kTextFieldLabelSize),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kTextFieldLine),
                  )),
            ),
            Expanded(
                child: destinationPlacePredictions.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                        itemCount: destinationPlacePredictions.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) => LocationListTile(
                              press: _onSelectDestination,
                              location: destinationPlacePredictions[index]
                                  .description!,
                              placeID:
                                  destinationPlacePredictions[index].placeID!,
                            ))),
            FutureBuilder<DocumentSnapshot>(
                future: getUserData(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    Map<String, dynamic> data =
                        snapshot.data!.data() as Map<String, dynamic>;
                    bool isFemale = data['isFemale'];
                    return Container(
                        color: const Color.fromARGB(255, 198, 57, 200),
                        child: CheckboxListTile(
                          title: const Text('Female Only Ride'),
                          enabled: isFemale,
                          checkColor: Colors.black,
                          selectedTileColor: Colors.black,
                          value: _isFemaleController,
                          onChanged: (bool? value) {
                            setState(() {
                              _isFemaleController = !_isFemaleController;
                            });
                          },
                          secondary: const Icon(Icons.woman_sharp),
                        ));
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            CustomButton(
              onTap: (_startPlaceIDController.text == "" ||
                      _destinationPlaceIDController.text == "")
                  ? () => {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                            content: Text(
                                "Please Enter Two Destinations & a passengers count"),
                            backgroundColor: Colors.red))
                      }
                  : () async {
                      final offers =
                          await RequestCarpoolController.getOfferList(
                              context: context,
                              destinationLocationID:
                                  _destinationPlaceIDController.text,
                              isFemaleOnly: _isFemaleController);
                      //print(offers);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext routeContextcontext) =>
                              AvailableOffersPage(offers: offers)));
                    },
              text: "Submit Request",
              color: buttonColor,
            )
          ],
        ),
      ),
    );
  }

  void placeAutocomplete(String query, bool start) async {
    // Just to cut down on api calls :)
    if (query.length < 3) {
      setState(() {
        startPlacePredictions = [];
      });
      return null;
    }

    String? response = await PlacesFetcher.fetchPlaces(query);
    if (response != null) {
      PlaceAutocompleteResponse result =
          PlaceAutocompleteResponse.parseAutocompleteResult(response);
      if (result.predictions != null) {
        setState(() {
          if (start) {
            startPlacePredictions = result.predictions!;
          } else {
            destinationPlacePredictions = result.predictions!;
          }
        });
      }
    }
  }

  void _onSelectStart(String location, String placeID) {
    setState(() {
      _startSearchFieldController.text = location;
      startPlacePredictions = [];
      _startPlaceIDController.text = placeID;
    });
  }

  void _onSelectDestination(String location, String placeID) {
    setState(() {
      _destinationSearchFieldController.text = location;
      destinationPlacePredictions = [];
      _destinationPlaceIDController.text = placeID;
    });
  }

  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
  }
}

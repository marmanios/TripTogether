// ignore: file_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterapp/common/widgets/custom_button.dart';
import 'package:flutterapp/common/widgets/location_list_tile.dart';
import 'package:flutterapp/offerCarpool/models/response_fetcher.dart';
import '../../constants.dart';
import '../models/place_auto_complete_response.dart';
import '../models/autocomplete_prediction.dart';

User? currentUser = FirebaseAuth.instance.currentUser;
String? phoneNumber;
String? name;
bool? isFemale;
int? rating;


class EnterDetailsPage extends StatefulWidget {
  final String taxiID;
  const EnterDetailsPage({Key? key, required this.taxiID}) : super(key: key);

  @override
  State<EnterDetailsPage> createState() =>
      // ignore: no_logic_in_create_state
      _EnterDetailsPageState(taxiID: taxiID);
}

class _EnterDetailsPageState extends State<EnterDetailsPage> {
  final String taxiID;
  final TextEditingController _maxPassengersController =
      TextEditingController();
  final TextEditingController _startSearchFieldController =
      TextEditingController();
  final TextEditingController _destinationSearchFieldController =
      TextEditingController();
  bool _isFemaleController = false;

  List<AutocompletePrediction> startPlacePredictions = [];
  List<AutocompletePrediction> destinationPlacePredictions = [];

  _EnterDetailsPageState({required this.taxiID});

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
                  color: registerTitleColor,
                  fontSize: loginTitleFontSize),
            ),
            Text(
              'TaxiID: $taxiID',
              style: const TextStyle(
                  color: registerTitleColor,
                  // fontWeight: FontWeight.bold,
                  fontSize: kTextFieldLabelSize),
            ),
            TextField(
              style: const TextStyle(color: registerTitleColor),
              controller: _maxPassengersController,
              inputFormatters: <TextInputFormatter>[
                FilteringTextInputFormatter.allow(RegExp(r'[1-8]{1}')),
              ],
              keyboardType: TextInputType.number,
              showCursor: false,
              decoration: const InputDecoration(
                  labelText: 'Max Passengers',
                  labelStyle: TextStyle(
                      color: kTextFieldLabelColor,
                      fontSize: kTextFieldLabelSize),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: kTextFieldLine),
                  )),
            ),
            TextField(
              style: const TextStyle(color: registerTitleColor),
              controller: _startSearchFieldController,
              onChanged: (value) => {placeAutocomplete(value,true)},
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
                            ))),
            TextField(
              style: const TextStyle(color: registerTitleColor),
              showCursor: false,
              onChanged: (value) => {placeAutocomplete(value,false)},
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
            const Spacer(
              flex: 1,
            ),
            CustomButton(
              onTap: () => {},
              text: "Submit Offer",
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
          if (start){startPlacePredictions = result.predictions!;}
          else{destinationPlacePredictions = result.predictions!;}
          
        });
      }
    }
  }

  void _onSelectStart(String newValue) {
    setState(() {
      _startSearchFieldController.text = newValue;
      startPlacePredictions = [];
    });
  }

  void _onSelectDestination(String newValue) {
    setState(() {
      _destinationSearchFieldController.text = newValue;
      destinationPlacePredictions = [];
    });
  }

  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(currentUser!.uid)
        .get();
  }
}
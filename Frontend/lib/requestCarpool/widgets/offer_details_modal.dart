import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/common/widgets/custom_InsertStars.dart';
import 'package:flutterapp/constants.dart';

class OfferDetailsModal extends StatefulWidget {
  final Map<String, dynamic> offerDetails;

  const OfferDetailsModal({Key? key, required this.offerDetails})
      : super(key: key);

  @override
  State<OfferDetailsModal> createState() =>
      // ignore: no_logic_in_create_state
      _OfferDetailsModalState(offerDetails: offerDetails);
}

class _OfferDetailsModalState extends State<OfferDetailsModal> {
  final Map<String, dynamic> offerDetails;
  List<Map<String, dynamic>> passengerDetails = [];

  _OfferDetailsModalState({required this.offerDetails});

  Future<void> _getPassengerData(List<dynamic> passengerIDs) async {
    List<Map<String, dynamic>> _details = [];
    for (var element in passengerIDs) {
      final passengerSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(element)
          .get();

      final passengerDetails = passengerSnapshot.data();
      _details.add(passengerDetails!);
    }
    setState(() {
      passengerDetails = _details;
    });
  }

  @override
  void initState() {
    super.initState();
    _getPassengerData(offerDetails["passengers"]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Title(
            color: buttonColor,
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  offerDetails["destination"]["formattedAddress"],
                  style: const TextStyle(
                      color: Colors.blue,
                      fontSize: 25,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ))),
        Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              "Fare: \$${offerDetails["fare"] / (offerDetails["passengers"].length + 2)}",
              style: const TextStyle(color: Colors.blue, fontSize: 22),
            )),
        Title(
            color: buttonColor,
            child: Padding(
                padding: const EdgeInsets.all(5),
                child: Text(
                  "Female Only: ${offerDetails["isFemaleOnly"].toString()}",
                  style: const TextStyle(
                    color: Color.fromARGB(255, 243, 33, 215),
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ))),
        const SizedBox(
          height: 25, 
        ),
        Title(
            color: buttonColor,
            child: const Padding(
                padding: EdgeInsets.all(5),
                child: Text(
                  "Passengers",
                  style: TextStyle(
                    color: Colors.blue,
                    fontSize: 22,
                  ),
                  textAlign: TextAlign.center,
                ))),
        Expanded(
            child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: passengerDetails.length,
                itemBuilder: (BuildContext context, int index) => SizedBox(
                      width: 200,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                          //set border radius more than 50% of height and width to make circle
                        ),
                        child: Column(children: [
                          Text(
                            passengerDetails[index]["name"],
                            style: const TextStyle(fontSize: 20),
                          ),
                          Center(
                            child: InsertStars(
                                numStars: passengerDetails[index]["rating"]),
                          ),
                        ]),
                      ),
                    ))),
        Padding(
            padding: const EdgeInsets.all(5),
            child: Text(
              "TaxiID: ${offerDetails["taxiID"]}",
              style: const TextStyle(color: Colors.blue, fontSize: 22),
            )),
        const Spacer(
          flex: 1,
        )
      ],
    );
  }
}

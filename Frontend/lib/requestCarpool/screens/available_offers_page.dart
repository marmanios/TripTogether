import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/activeCarpool/controllers/active_carpool_controller.dart';
import 'package:flutterapp/activeCarpool/screens/active_carpool_page.dart';
import 'package:flutterapp/requestCarpool/controllers/request_carpool_controller.dart';
import 'package:flutterapp/requestCarpool/widgets/offer_details_modal.dart';
import 'package:get/get.dart';

import '../../constants.dart';

class AvailableOffersPage extends StatefulWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> offers;
  const AvailableOffersPage({
    Key? key,
    required this.offers,
  }) : super(key: key);

  @override
  State<AvailableOffersPage> createState() =>
      // ignore: no_logic_in_create_state
      _AvailableOffersPageState(offers: offers);
}

class _AvailableOffersPageState extends State<AvailableOffersPage> {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> offers;
  bool _requestPending = false;
  _AvailableOffersPageState({required this.offers});
  DatabaseReference requestRef = FirebaseDatabase.instance.ref("requests");

  static SnackBar generateSnackbar({required String text}) {
    return SnackBar(content: Text(text), backgroundColor: Colors.red);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
            title: const Text(
              "Available Offers",
              style: TextStyle(color: buttonColor),
            ),
            backgroundColor: Colors.white,
            leading: const BackButton(
              color: buttonColor,
            )),
        body: SingleChildScrollView(
          physics: const ScrollPhysics(),
          child: Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: offers.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                      decoration: const BoxDecoration(
                        //BoxDecoration
                        border: Border(
                            bottom: BorderSide(
                                //Add border as a divider
                                color: Color.fromARGB(255, 0, 0, 0))),
                      ),
                      child: ListTile(
                        leading: const Icon(
                          Icons.person,
                          color: buttonColor,
                        ),
                        tileColor: Colors.black12,
                        title: Text(
                          offers[index].data()["destination"]
                              ["formattedAddress"],
                          style: const TextStyle(color: Colors.blue),
                        ),
                        subtitle: Text(
                          "Fare: ${(offers[index].data()["fare"] / (offers[index].data()["passengers"].length + 1)).toStringAsFixed(2)}",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        onTap: () => {
                          RequestCarpoolController.submitRequest(
                                  offers[index].id)
                              .then((value) => {
                                    //Check for rejection
                                    requestRef
                                        .child(offers[index].id)
                                        .onChildRemoved
                                        .listen((event) {
                                      Navigator.of(context).popUntil((route) {
                                        return route.settings.name ==
                                            'RequestCarpoolPage';
                                      });
                                      if (event.snapshot.value == "Rejected") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(generateSnackbar(
                                                text: "Cancelled"));
                                      }
                                    }),
                                    requestRef
                                        .child(offers[index].id)
                                        .onChildChanged
                                        .listen((event) {
                                      Navigator.of(context).popUntil((route) {
                                        return route.settings.name ==
                                            'RequestCarpoolPage';
                                      });
                                      if (event.snapshot.value == "Accepted") {
                                        ActiveCarpoolController.setData(
                                            carpoolID: offers[index].id,
                                            offererID: offers[index]
                                                .data()["offererID"]);
                                        Get.to(const ActiveCarpoolPage());
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(generateSnackbar(
                                                text: "Accepted"));
                                      } else if (event.snapshot.value ==
                                          "Rejected") {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(generateSnackbar(
                                                text: "Rejected"));
                                      }
                                    }),
                                    showDialog(
                                      context: context,
                                      builder: (_) => WillPopScope(
                                          child: AlertDialog(
                                            title: const Text("Request Sent!"),
                                            content: const Text(
                                                "Waiting for offerer to accept"),
                                            actions: [
                                              TextButton(
                                                  onPressed: () => {
                                                        RequestCarpoolController
                                                            .cancelRequest(
                                                                offers[index]
                                                                    .id)
                                                      },
                                                  child: const Text(
                                                      "Cancel Request"))
                                            ],
                                          ),
                                          onWillPop: () async {
                                            return false;
                                          }),
                                      barrierDismissible: false,
                                    )
                                  })
                        },
                        onLongPress: () => showModalBottomSheet(
                          context: context,
                          backgroundColor: Colors.transparent,
                          isScrollControlled: true,
                          builder: (BuildContext context) {
                            return BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height * 0.7,
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20),
                                  ),
                                ),
                                child: OfferDetailsModal(
                                  offerDetails: offers[index].data(),
                                ),
                              ),
                            );
                          },
                        ),
                        trailing: const Icon(Icons.menu),
                      ));
                },
              )
            ],
          ),
        ));
  }
}

import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp/requestCarpool/controllers/request_carpool_controller.dart';
import 'package:flutterapp/requestCarpool/widgets/offer_details_modal.dart';

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
                          "Fare: ${
                            (offers[index].data()["fare"]/(offers[index].data()["passengers"].length + 1)).toStringAsFixed(2)
                            }",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        onTap: () => {
                          RequestCarpoolController.submitRequest(
                                  offers[index].id)
                              .then((value) => {
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
                                                          Navigator.of(context)
                                                              .pop()
                                                        },
                                                    child: const Text(
                                                        "Cancel Request"))
                                              ],
                                            ),
                                            onWillPop: () async {
                                              return false;
                                            }),
                                        barrierDismissible: false)
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

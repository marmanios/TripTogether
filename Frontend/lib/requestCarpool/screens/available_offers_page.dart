import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';

class AvailableOffersPage extends StatelessWidget {
  final List<QueryDocumentSnapshot<Map<String, dynamic>>> offers;
  const AvailableOffersPage({
    Key? key,
    required this.offers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(offers);
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
                        subtitle: Text("Fare: ${offers[index].data()["fare"] /
                                  (offers[index].data()["passengers"].length +
                                      2)}",
                          style: const TextStyle(color: Colors.blue),
                        ),
                        onTap: () => print(offers[index].id),
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
                                child: Column(
                                  children: [Text(offers[index].data().toString())],
                                ),
                              ),
                            );
                          },
                        ),
                        trailing: Icon(Icons.menu),
                      ));
                },
              )
            ],
          ),
        ));
  }
}

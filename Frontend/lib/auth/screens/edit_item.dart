import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class EditItem extends StatelessWidget {
  EditItem(this._user, {Key? key}) {
    _nameController = TextEditingController(text: _user['name']);
    _phoneNumberController = TextEditingController(text: _user['phoneNumber']);

    _reference =
        FirebaseFirestore.instance.collection('users').doc(_user['id']);
  }

  final Map _user;
  late DocumentReference _reference;

  late TextEditingController _nameController;
  late TextEditingController _phoneNumberController;
  GlobalKey<FormState> _key = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit an item'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    hintText: 'Enter the name of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item name';
                  }

                  return null;
                },
              ),
              TextFormField(
                controller: _phoneNumberController,
                decoration: const InputDecoration(
                    hintText: 'Enter the phoneNumber of the item'),
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the item phoneNumber';
                  }

                  return null;
                },
              ),
              ElevatedButton(
                  onPressed: () async {
                    if (_key.currentState!.validate()) {
                      String name = _nameController.text;
                      String phoneNumber = _phoneNumberController.text;

                      //Create the Map of data
                      Map<String, String> dataToUpdate = {
                        'name': name,
                        'phoneNumber': phoneNumber
                      };

                      //Call update()
                      _reference.update(dataToUpdate);
                    }
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final _formKey = GlobalKey<FormState>();

  String _textField1 = '';
  String _textField2 = '';
  String _textField3 = '';

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Do something with the form data
      print('Text Field 1: $_textField1');
      print('Text Field 2: $_textField2');
      print('Text Field 3: $_textField3');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Text Field 1'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _textField1 = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Text Field 2'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _textField2 = value!;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Text Field 3'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                onSaved: (value) {
                  _textField3 = value!;
                },
              ),
              SizedBox(height: 16.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    child: Text('Cancel'),
                    onPressed: () {
                      // Do something when the user cancels the form
                    },
                  ),
                  ElevatedButton(
                    child: Text('Submit'),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
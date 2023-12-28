// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:convert';

import 'package:biscooter/services/connection.dart';
import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/services/user.dart';
import "package:flutter/material.dart";
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart';

class SendComplaint extends StatefulWidget {
  const SendComplaint({super.key});

  @override
  State<SendComplaint> createState() => _SendComplaintState();
}

class _SendComplaintState extends State<SendComplaint> {
  final _formController = GlobalKey<FormState>();
  final _complaintDetails = TextEditingController();
  String? _selectedType;

  final _complaintTypes = [
    "On Bike",
    "On Scooter",
    "On Station",
    "On Service",
  ];

  DropdownMenuItem<String> _buildDropdownMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }

  void send() async {
    if (_formController.currentState!.validate()) {
      try {
        final date = DateTime.now().toString();
        final details = _complaintDetails.text;
        final type = _selectedType;
        Response response = await post(
          Uri.parse(
              "${const Connection().baseUrl}/users/ClientActions6/${User().getId}"),
          headers: <String, String>{
            'Content-Type': 'application/json',
          },
          body: jsonEncode(<String, dynamic>{
            "DATE": date,
            "DESCRIPTION": details,
            "TYPE": type
          }),
        );

        debugPrint(response.body);
        if (response.statusCode == 200) {
          if (mounted) {
            Navigator.pop(context);
          }
        } else {
          Fluttertoast.showToast(
            msg: "Something went wrong!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16,
          );
        }
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  changeType(String? value) {
    setState(() {
      _selectedType = value;
    });
    debugPrint(_selectedType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Make a Complaint"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        // the styling
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.surface,
              Theme.of(context).colorScheme.surfaceTint,
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: const [
              0.03,
              0.2,
            ],
          ),
        ),

        child: Column(
          children: [
            SizedBox(
              height: const MyDimensions().spaceHeight,
            ),

            // the white container
            Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 82),
                width: double.infinity,
                decoration: const ShapeDecoration(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(48)),
                  ),
                ),

                // the colum of input fields
                child: SingleChildScrollView(
                  child: Form(
                    key: _formController,
                    child: Column(
                      children: [
                        SizedBox(
                          width: MediaQuery.of(context).size.width - 30,
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(17.0),
                              border: Border.all(
                                color: Theme.of(context).colorScheme.surface,
                                width: 2,
                              ),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButtonFormField(
                                value: _selectedType,
                                items: _complaintTypes
                                    .map(_buildDropdownMenuItem)
                                    .toList(),
                                onChanged: changeType,
                                iconEnabledColor:
                                    Theme.of(context).colorScheme.surface,
                                iconSize: 30,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 94, 94, 94),
                                  fontWeight: FontWeight.bold,
                                ),
                                validator: (value) {
                                  if (value == null)
                                    return "Select complaint type";
                                  return null;
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  hintText: "Choose a Complaint Type",
                                  errorStyle: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 10,
                                  ),
                                  hintStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                  ), // Style for the error message
                                ),
                              ),
                            ),
                          ),
                        ),
                        // const SizedBox(height: 40,),
                        Input(
                          width: MediaQuery.of(context).size.width - 40,
                          height: 300,
                          label: 'Complaint Details',
                          controller: _complaintDetails,
                          password: _complaintDetails,
                        ),

                        // the sing up button
                        Padding(
                          padding: const EdgeInsets.only(top: 60.0, bottom: 25),
                          child: ElevatedButton(
                            onPressed: send,
                            style: ButtonStyle(
                              fixedSize: const MaterialStatePropertyAll(
                                Size(300, 60),
                              ),
                              backgroundColor: MaterialStatePropertyAll(
                                  Theme.of(context)
                                      .colorScheme
                                      .primaryContainer),
                            ),
                            child: Text("Send",
                                style: Theme.of(context).textTheme.labelLarge),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final double? height;
  final double width;
  final String label;
  final TextEditingController controller;
  final TextEditingController password;
  const Input({
    super.key,
    required this.width,
    required this.label,
    required this.controller,
    required this.password,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 4.0),
      child: SizedBox(
        width: width, // Set the width
        height: height ?? 50, // Set the height
        child: TextFormField(
          keyboardType: TextInputType.text,
          maxLines: null,
          //styling of the input field
          decoration: InputDecoration(
            border:
                const UnderlineInputBorder(), // This gives a border at the bottom
            enabledBorder: const UnderlineInputBorder(
              borderSide: BorderSide(
                color: Colors.black,
                width: 1.4,
              ), // This gives a border at the bottom when enabled
            ),
            // labelText: label,
            hintText: label,
            hintStyle:
                const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
            errorStyle:
                const TextStyle(fontSize: 10, fontWeight: FontWeight.normal),
          ),

          // the different validations
          validator: (value) {
            if (value != null && value.isEmpty) return "Enter $label";
            if (value!.length < 50)
              return "Complaint message must be at least 50 characters long";

            return null;
          },

          controller: controller,
        ),
      ),
    );
  }
}

// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:biscooter/services/my_dimensions.dart';
import 'package:biscooter/widget/white_card.dart';
import "package:flutter/material.dart";

import 'add_biscooter_sub/chose_view.dart';

class AddBiscooter extends StatefulWidget {
  const AddBiscooter({super.key});

  @override
  State<AddBiscooter> createState() => _AddBiscooterState();
}

class _AddBiscooterState extends State<AddBiscooter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text("Add a Biscooter"),
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
              height: const MyDimensions().spaceHeight - 20,
            ),

            // the white container
            const WhiteCard(
              top: 22,
              child: WhiteCardContent(),
            ),
          ],
        ),
      ),
    );
  }
}

class WhiteCardContent extends StatefulWidget {
  const WhiteCardContent({
    super.key,
  });

  @override
  State<WhiteCardContent> createState() => _WhiteCardContentState();
}

class _WhiteCardContentState extends State<WhiteCardContent> {
  final controller = PageController(initialPage: 1);
  final double height = 230;
  final double width = 305;
  String type = "";

  setType(String chosen) {
    setState(() {
      type = chosen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: controller,
      // physics: const NeverScrollableScrollPhysics(),
      children: [
        ChoseView(
          height: height,
          width: width,
          type: type,
          choose: setType,
          controller: controller,
        ),
        DataView(type: type)
      ],
    );
  }
}

class DataView extends StatefulWidget {
  const DataView({super.key, required this.type});
  final String type;

  @override
  State<DataView> createState() => DataViewState();
}

class DataViewState extends State<DataView> {
  final _formController = GlobalKey<FormState>();
  final _brand = TextEditingController();
  final _size = TextEditingController();
  final _weight = TextEditingController();
  final _range = TextEditingController();
  final _maxSpeed = TextEditingController();
  final _batteryCapacity= TextEditingController();

  String? _bikeType;
  int? _selectedGearsNum;

  final _bikeTypes = [
    "Road Bike",
    "BMX Bike",
    "Fixed Gear Bike",
    "City Bike",
    "Track Bike",
  ];

  final _gearsNum = [1, 3, 7, 8, 9];

  DropdownMenuItem<String> _buildDropdownMenuItem(String item) {
    return DropdownMenuItem(
      value: item,
      child: Text(item),
    );
  }
  DropdownMenuItem<int> _buildDropdownMenuItem2(int item) {
    return DropdownMenuItem(
      value: item,
      child: Text('$item'),
    );
  }

  changeType(String? value) {
    setState(() {
      _bikeType = value;
    });
  }
  selectGears(int? value) {
    setState(() {
      _selectedGearsNum = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: _formController,
        child: Column(
          children: [
            Input(
              width: MediaQuery.of(context).size.width - 30,
              label: 'Brand',
              controller: _brand,
              password: _brand,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Input(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  label:
                      (widget.type == 'bike') ? 'Frame Size' : 'Wheelbase Size',
                  controller: _size,
                  password: _size,
                ),
                (widget.type == 'scooter')
                    ? Input(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        label: 'Range',
                        controller: _range,
                        password: _range,
                      )
                    : Input(
                        width: MediaQuery.of(context).size.width / 2 - 20,
                        label: 'Weight',
                        controller: _weight,
                        password: _weight,
                      ),
              ],
            ),

            // the rest of the input fields
            (widget.type == 'bike') ?  Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.only(right: 4),
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  child: DropdownButtonFormField(
                    value: _bikeType,
                    items: _bikeTypes.map(_buildDropdownMenuItem).toList(),
                    onChanged: changeType,
                    iconEnabledColor: Theme.of(context).colorScheme.surface,
                    iconSize: 30,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 94, 94, 94),
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value == null) return "Select bike type";
                      return null;
                    },
                    decoration: const InputDecoration(
                      // border: InputBorder.none,
                      hintText: "Bike Type",
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
                
                Container(
                  padding: const EdgeInsets.only(left: 4),
                  width: MediaQuery.of(context).size.width / 2 - 16,
                  child: DropdownButtonFormField(
                    value: _selectedGearsNum,
                    items: _gearsNum.map(_buildDropdownMenuItem2).toList(),
                    onChanged: selectGears,
                    iconEnabledColor: Theme.of(context).colorScheme.surface,
                    iconSize: 30,
                    style: const TextStyle(
                      fontSize: 16,
                      color: Color.fromARGB(255, 94, 94, 94),
                      fontWeight: FontWeight.bold,
                    ),
                    validator: (value) {
                      if (value == null) return "Select number of gears";
                      return null;
                    },
                    decoration: const InputDecoration(
                      // border: InputBorder.none,
                      hintText: "Gears Number",
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
              ],
            )
            : Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Input(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  label:'Max Speed',
                  controller: _maxSpeed,
                  password: _maxSpeed,
                ),
                Input(
                  width: MediaQuery.of(context).size.width / 2 - 20,
                  label: 'Battery Capacity',
                  controller: _batteryCapacity,
                  password: _batteryCapacity,
                ),
              ],
            ),

            // the sing up button
            Padding(
              padding: const EdgeInsets.only(top: 60.0, bottom: 25),
              child: ElevatedButton(
                onPressed: () {
                  _formController.currentState!.validate();
                },
                style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(
                    Size(300, 60),
                  ),
                  backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.primaryContainer),
                ),
                child: Text("Add My Biscooter",
                    style: Theme.of(context).textTheme.labelLarge),
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
          keyboardType: (label == "Brand" ) ? TextInputType.text : TextInputType.number,
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
            return null;
          },

          controller: controller,
        ),
      ),
    );
  }
}
import "package:flutter/material.dart";

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  static const double spaceHeight = 180;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          title: const Text("Sign up"),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Container(
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
                0.01,
                1,
              ],
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: spaceHeight,
              ),

              // the white container
              Expanded(
                child: Container(
                  height: MediaQuery.of(context).size.height - spaceHeight,
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(48)),
                    ),
                  ),
              
              
                  // the colum of input fields
                  child: Column(
                    children: [
                      // the name input fields
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Input(width: MediaQuery.of(context).size.width/3 - 20, label: 'First Name',),
                          const SizedBox(width: 10),
                          Input(width: MediaQuery.of(context).size.width/3 - 20, label: 'Middle Name',),
                          const SizedBox(width: 10),
                          Input(width: MediaQuery.of(context).size.width/3 - 20, label: 'Last Name',),
                        ],
                      ),
                      Input(width: MediaQuery.of(context).size.width - 30, label: 'Email',),
                      Input(width: MediaQuery.of(context).size.width - 30, label: 'Username',),
                      
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

class Input extends StatelessWidget {
  final double width;
  final String label;
  const Input({
    super.key, required this.width, required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width, // Set the width
      height: 50, // Set the height
      child: TextField(
        decoration: InputDecoration(
          border: const UnderlineInputBorder(), // This gives a border at the bottom
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.black, width: 1.4), // This gives a border at the bottom when enabled
          ),
          labelText: label,
        ),
      ),
    );
  }
}

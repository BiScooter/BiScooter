// ignore_for_file: curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class WhiteCard extends StatelessWidget {
  final double top;
  final Widget child;
  const WhiteCard({
    super.key, required this.child, required this.top,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.only(top: top),
        alignment: Alignment.center,
        width: double.infinity,
        decoration: const ShapeDecoration(
          color: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.only(topLeft: Radius.circular(48)),
          ),
        ),

        // the colum
        child: child,
      ),
    );
  }
}

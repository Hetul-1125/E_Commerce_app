import 'package:flutter/material.dart';
class CostomTextField extends StatelessWidget {
  String?labText;
  TextInputType?keyboardtype;
  TextEditingController?controller;
  CostomTextField({this.controller,this.keyboardtype,this.labText});
  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        labelText: labText,
      ),
      keyboardType: keyboardtype,
      controller:controller,
    );
  }
}

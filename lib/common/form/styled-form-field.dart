import 'package:flutter/material.dart';

class StyledFormField extends StatelessWidget {
  final String hint;
  final String label;
  final String? suffix;
  final Function(String?) onSaved;

  StyledFormField({
    required this.hint,
    required this.label,
    required this.onSaved,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: hint,
          suffix: Text(suffix ?? ''),
          labelText: label,
          labelStyle: TextStyle(color: Colors.pinkAccent),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black12,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.pinkAccent,
              width: 2.0,
            ),
          ),
        ),
        onSaved: this.onSaved,
      ),
    );
  }
}

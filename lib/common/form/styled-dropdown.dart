import 'package:flutter/material.dart';

class StyledDropdown<T> extends StatelessWidget {
  StyledDropdown({
    required this.handleChange,
    required this.selected,
    required this.items,
    required this.label,
  });

  final void Function(T?) handleChange;
  final T selected;
  final List<DropdownMenuItem<T>> items;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      isExpanded: true,
      value: selected,
      onChanged: handleChange,
      items: items,
      decoration: InputDecoration(
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
    );
  }
}

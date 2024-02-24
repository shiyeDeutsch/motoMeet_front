import 'package:flutter/material.dart';

class CustomDropdown extends StatelessWidget {
  final InputDecoration inputDecorationTheme;
  final DropdownMenuItem<dynamic>? initialSelection;
  // final TextEditingController controller;
  final Function(dynamic) onSelected;
  final List<DropdownMenuItem<dynamic>> dropdownMenuEntries;

  const CustomDropdown({
    Key? key,
    required this.inputDecorationTheme,
    this.initialSelection,
    //required this.controller,
    required this.onSelected,
    required this.dropdownMenuEntries,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<dynamic>(
      borderRadius: const BorderRadius.all(
        Radius.circular(30.0),
      ),
      menuMaxHeight: 250,
      isExpanded: true,
      decoration: InputDecoration(
        border: inputDecorationTheme.border,
        hintText: inputDecorationTheme.hintText,
        hintStyle: inputDecorationTheme.hintStyle,
        labelStyle: inputDecorationTheme.labelStyle,
        errorStyle: inputDecorationTheme.errorStyle,
      ),
      //value: initialSelection  ,
      items: dropdownMenuEntries,
      onChanged: (value) {
        onSelected(value);
      },
    );
  }
}

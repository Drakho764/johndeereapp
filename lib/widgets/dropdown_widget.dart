import 'package:flutter/material.dart';

class DropDownWidget extends StatefulWidget {
  String? controller = '';
  List<String> values = [];
  DropDownWidget({super.key, this.controller, required this.values});
  int indexSelected = 0;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
  List<String> dropDownValues = [];
  String dropDownValue = '';
  int indexSelected = 0;

  @override
  Widget build(BuildContext context) {
    dropDownValues = widget.values;
    dropDownValue = widget.controller!;
    return Container(
      padding: const EdgeInsets.all(8),
      child: DropdownButtonFormField<String>(
        value: dropDownValue,
        dropdownColor: const Color.fromARGB(255, 38, 124, 127),
        icon: const Icon(Icons.info),
        decoration: InputDecoration(
            prefixIcon: Container(
              margin: const EdgeInsets.only(left: 14, right: 14),
              child: const Icon(
                Icons.info,
              ),
            ),
            hintText: "Status",
            labelText: "Status"),
        items: dropDownValues.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? newValue) {
          dropDownValue = newValue!;
          widget.controller = newValue;
          widget.indexSelected = GetIndex(newValue);
        },
      ),
    );
  }

  int GetIndex(data) {
    return dropDownValues.indexOf(data) ?? 0;
  }
}

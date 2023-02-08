import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DropdownRaw extends StatefulWidget {
  String label;
  dynamic selected;
  Function(dynamic) onChanged;
  List<DropdownMenuItem<dynamic>> menuItem;

  DropdownRaw(
      {required this.label, required this.menuItem, required this.onChanged, this.selected});
  @override
  _DropdownRawState createState() => _DropdownRawState();
}

class _DropdownRawState extends State<DropdownRaw> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      isExpanded: true,
      hint: Text(
        widget.label,
        // style: TextTypography.text14.copyWith(fontWeight: FontWeight.bold),
      ),
      value: widget.selected,
      items: widget.menuItem,
      icon: Icon(
        Icons.arrow_drop_down,
        // color: Pallete.primary,
      ),
      onChanged: (dynamic data) {
        widget.onChanged(data);
        setState(() {
          widget.selected = data;
        });
      },
    );
  }
}

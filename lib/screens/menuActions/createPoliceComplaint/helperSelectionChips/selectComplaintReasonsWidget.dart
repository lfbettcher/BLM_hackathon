import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/constants.dart';

class SelectComplaintWidget extends StatefulWidget {
  final String complaint;
  final Function toggleSelect;

  SelectComplaintWidget({Key key, this.complaint, this.toggleSelect}) : super(key: key);

  @override
  _SelectComplaintWidgetState createState() => _SelectComplaintWidgetState();
}

class _SelectComplaintWidgetState extends State<SelectComplaintWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FilterChip(
          label: Text("${widget.complaint}"),
          labelStyle: TextStyle(color: color5, fontSize: 16.0, fontWeight: FontWeight.bold),
          selected: _isSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0),),
          backgroundColor: Color(0xffededed),
          onSelected: (isSelected) {
            setState(() {
              _isSelected = isSelected;
              widget.toggleSelect(widget.complaint);
            });
          },
          selectedColor: color7
      ),
    );
  }
}



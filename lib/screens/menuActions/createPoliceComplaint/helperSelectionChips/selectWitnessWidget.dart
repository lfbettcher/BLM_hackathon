import 'package:blmhackathon/models/witness.dart';
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/constants.dart';

class SelectWitnessWidget extends StatefulWidget {
  final Witness witness;
  final Function toggleSelect;

  SelectWitnessWidget({Key key, this.witness, this.toggleSelect}) : super(key: key);

  @override
  _SelectWitnessWidgetState createState() => _SelectWitnessWidgetState();
}

class _SelectWitnessWidgetState extends State<SelectWitnessWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FilterChip(
          label: Text("${widget.witness.name}"),
          labelStyle: TextStyle(color: color5, fontSize: 16.0, fontWeight: FontWeight.bold),
          selected: _isSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0),),
          backgroundColor: Color(0xffededed),
          onSelected: (isSelected) {
            setState(() {
              _isSelected = isSelected;
              widget.toggleSelect(widget.witness);
            });
          },
          selectedColor: color7
      ),
    );
  }
}



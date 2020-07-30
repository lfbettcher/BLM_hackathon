import 'package:flutter/material.dart';
import 'package:blmhackathon/models/dateTimeLocationStamp.dart';
import 'package:blmhackathon/shared/constants.dart';

class SelectDateTimeLocationWidget extends StatefulWidget {
  final DateTimeLocationStamp dateTimeLocationStamp;
  final Function toggleSelect;

  SelectDateTimeLocationWidget({Key key, this.dateTimeLocationStamp, this.toggleSelect}) : super(key: key);

  @override
  _SelectDateTimeLocationWidgetState createState() => _SelectDateTimeLocationWidgetState();
}

class _SelectDateTimeLocationWidgetState extends State<SelectDateTimeLocationWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ChoiceChip(
        label: Text(widget.dateTimeLocationStamp.date),
        labelStyle: TextStyle(color: color5, fontSize: 16.0, fontWeight: FontWeight.bold),
        selected: _isSelected,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
              30.0),),
        backgroundColor: Color(0xffededed),
        onSelected: (isSelected) {
          setState(() {
            _isSelected = isSelected;
            widget.toggleSelect(widget.dateTimeLocationStamp);
          });
        },
        selectedColor: color7,
      ),
    );
  }
}



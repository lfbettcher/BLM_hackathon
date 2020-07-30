import 'package:flutter/material.dart';
import 'package:blmhackathon/models/policeBadge.dart';
import 'package:blmhackathon/shared/constants.dart';

class SelectPoliceWidget extends StatefulWidget {
  final Badge badge;
  final Function toggleSelect;

  SelectPoliceWidget({Key key, this.badge, this.toggleSelect}) : super(key: key);

  @override
  _SelectPoliceWidgetState createState() => _SelectPoliceWidgetState();
}

class _SelectPoliceWidgetState extends State<SelectPoliceWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FilterChip(
          label: Text("# ${widget.badge.badgeNumber}"),
          labelStyle: TextStyle(color: color5, fontSize: 16.0, fontWeight: FontWeight.bold),
          selected: _isSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0),),
          backgroundColor: Color(0xffededed),
          onSelected: (isSelected) {
            setState(() {
              _isSelected = isSelected;
              widget.toggleSelect(widget.badge);
            });
          },
          selectedColor: color7
      ),
    );
  }
}



import 'package:flutter/material.dart';
import 'package:blmhackathon/models/licensePlate.dart';
import 'package:blmhackathon/shared/constants.dart';

class SelectLicensePlateWidget extends StatefulWidget {
  final License license;
  final Function toggleSelect;

  SelectLicensePlateWidget({Key key, this.license, this.toggleSelect}) : super(key: key);

  @override
  _SelectLicensePlateWidgetState createState() => _SelectLicensePlateWidgetState();
}

class _SelectLicensePlateWidgetState extends State<SelectLicensePlateWidget> {
  var _isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: FilterChip(
          label: Text("# ${widget.license.licenseNumber}"),
          labelStyle: TextStyle(color: color5, fontSize: 16.0, fontWeight: FontWeight.bold),
          selected: _isSelected,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
                30.0),),
          backgroundColor: Color(0xffededed),
          onSelected: (isSelected) {
            setState(() {
              _isSelected = isSelected;
              widget.toggleSelect(widget.license);
            });
          },
          selectedColor: color7
      ),
    );
  }
}



///File description: Generic menu item container that takes in the menu name
///and links it to the widget that it clicks to
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/constants.dart';

class MenuItem extends StatefulWidget {
  final String menuName;
  final Widget route;
  MenuItem({this.menuName, this.route});
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: 300,
          height: 80,
          decoration: new BoxDecoration(
              color: color4,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Center(child: Text(widget.menuName, style: TextStyle(color: color1, fontSize: defaultFontSize)))
      ),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => widget.route));
      },
    );
  }
}

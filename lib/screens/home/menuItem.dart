///File description: Generic menu item container that takes in the menu name
///and links it to the widget that it clicks to
import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/constants.dart';

class MenuItem extends StatefulWidget {
  final String menuName;
  final Widget route;
  final Icon icon;
  final Color color;
  MenuItem({this.menuName, this.route, this.icon, this.color});
  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
          width: 375,
          height: 90,
          decoration: new BoxDecoration(
              color: widget.color,
              borderRadius: BorderRadius.all(Radius.circular(20))
          ),
          child: Center(
            child: Row(
              children: <Widget>[
                SizedBox(width: 30),
                widget.icon,
                SizedBox(width: 15),
                Text(widget.menuName, style: TextStyle(color: color3, fontSize: 20))
              ],
            )
          )//Center(child: Text(widget.menuName, style: TextStyle(color: color3, fontSize: 25)))
      ),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => widget.route));
      },
    );
  }
}

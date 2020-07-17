import 'package:flutter/material.dart';
import 'package:blmhackathon/shared/constants.dart';

class HomeMenuItem extends StatefulWidget {
  final String menuName;
  final Widget route;
  HomeMenuItem({this.menuName, this.route});
  @override
  _HomeMenuItemState createState() => _HomeMenuItemState();
}

class _HomeMenuItemState extends State<HomeMenuItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 300,
        height: 90,
          decoration: new BoxDecoration(
              color: color4,
              borderRadius: BorderRadius.all(Radius.circular(20))
      ),
          child: Center(child: Text(widget.menuName, style: TextStyle(color: color1, fontSize: 18)))
      ),
      onTap: (){
        Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => widget.route));
      },
    );
  }
}

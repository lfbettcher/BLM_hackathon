import 'package:blmhackathon/models/policeBadge.dart';
///File description: Card layout for an individual badge
import 'package:flutter/material.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/shared/constants.dart';

class BadgeCard extends StatefulWidget {
  final Badge badge;
  final String userId;

  BadgeCard({this.badge, this.userId});
  @override
  _BadgeCardState createState() => _BadgeCardState();
}

class _BadgeCardState extends State<BadgeCard> {

  @override
  Widget build(BuildContext context) {

    ///pop up box to confirm deletion
    confirmDeleteDialog(BuildContext context){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Text("Are you sure you want to delete this badge entry?"),
            content: Row(children: <Widget>[
              SizedBox(height: 25),
              RaisedButton(
                  color: color2,
                  onPressed: () async {
                    await DatabaseService(uid: widget.userId).deleteBadge(widget.badge.badgeId);
                    Navigator.of(context).pop();
                  },
                  textColor: Colors.white,
                  child: Text("Yes")),
              SizedBox(width: 55),
              RaisedButton(
                  color: color6,
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  textColor: Colors.white,
                  child: Text("No")),
            ],)
        );
      }
      );
    }

    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Container(
                child: Column(
                  children: <Widget>[
                      ListTile(
                          title: Text("#${widget.badge.badgeNumber}"
                          )),
                      FlatButton(
                        textColor: color6,
                        child: Row(children: <Widget>[
                          Icon(Icons.delete),
                          SizedBox(width: 5),
                          Text("Delete", style: TextStyle(fontSize: 15))
                        ],),
                        onPressed: (){
                          confirmDeleteDialog(context);
                        },
                      ),
                  ],
                )


              )
            ),
    );
  }
}

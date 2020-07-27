///File description: Card layout for an individual witness
import 'package:flutter/material.dart';
import 'package:blmhackathon/models/witness.dart';
import 'package:blmhackathon/services/database.dart';
import 'package:blmhackathon/shared/constants.dart';
import 'package:blmhackathon/screens/menuActions/document_situation/menuActions/witnessContactsDocumentation/editWitnessInfo.dart';

class WitnessCard extends StatefulWidget {
  final Witness witness;
  final String userId;

  WitnessCard({this.witness, this.userId});
  @override
  _WitnessCardState createState() => _WitnessCardState();
}

class _WitnessCardState extends State<WitnessCard> {
  @override
  Widget build(BuildContext context) {

    ///pop up box to confirm deletion
    confirmDeleteDialog(BuildContext context){
      return showDialog(context: context, builder: (context){
        return AlertDialog(
            title: Text("Are you sure you want to delete this witness entry?"),
            content: Row(children: <Widget>[
              SizedBox(height: 25),
              RaisedButton(
                  color: color2,
                  onPressed: () async {
                    await DatabaseService(uid: widget.userId).deleteWitness(widget.witness.witnessId);
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

    ///the actual card that is being returned
    return Padding(
        padding: EdgeInsets.only(top: 8.0),
        child: Card(
            margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
            child: Container(
              child: ListTile(
                title: Text(widget.witness.name, style: TextStyle(fontSize: 22)),
                subtitle: Column(children: <Widget>[
                  SizedBox(height: 15),
                  Text("Email: ${widget.witness.email}", style: TextStyle(fontSize: defaultFontSize)),
                  SizedBox(height: 15),
                  Text("Phone: ${widget.witness.phone}", style: TextStyle(fontSize: defaultFontSize)),
                  SizedBox(height: 15),
                  Text("Alternate Phone: ${widget.witness.altPhone}", style: TextStyle(fontSize: defaultFontSize)),
                  SizedBox(height: 15),
                  ButtonBar(
                    children: <Widget>[
                      FlatButton(
                        textColor: color2,
                        child: Row(children: <Widget>[
                          Icon(Icons.edit),
                          SizedBox(width: 5),
                          Text("Edit", style: TextStyle(fontSize: 15))
                        ],),
                        onPressed: (){
                          Navigator.of(context).pop();
                          Navigator.push(
                              context,
                              new MaterialPageRoute(
                                  builder: (BuildContext context) => new EditWitnessInfo(witness: widget.witness, userId: widget.userId)));
                        },
                      ),
                      SizedBox(width: 15),
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
                ],),
            ),
        )
    ));
  }
}

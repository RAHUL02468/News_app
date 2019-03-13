import 'package:flutter/material.dart';


class LoadingContainer extends StatelessWidget{

  Widget build(context){
    return Column(
      children: <Widget>[
        ListTile(
          title: buildContainer(),
          subtitle: buildContainer(),
        ),
        Divider(),
      ],
    );
  }
  Widget buildContainer(){
    return Container(
      height: 25.0,
      width: 150.0,
      color: Colors.grey[200],
      margin: EdgeInsets.only(top: 5.0,bottom: 5.0),
    );
  }
}
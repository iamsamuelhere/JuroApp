import 'package:flutter/material.dart';
import 'package:newsapp/components/AppBar.dart';


class EntertainmentChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child:Text("Entertainment")
      ),
    );
  }
}
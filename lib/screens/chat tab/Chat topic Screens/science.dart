import 'package:flutter/material.dart';
import 'package:newsapp/components/AppBar.dart';

class ScienceChat extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: Container(
        child:Text("Science")
      ),
    );
  }
}
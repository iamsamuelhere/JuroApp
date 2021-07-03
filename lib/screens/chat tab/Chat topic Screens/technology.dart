import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/components/AppBar.dart';
import 'package:newsapp/screens/chat%20tab/authScreen.dart';
import 'package:newsapp/service/GoogleAuth.dart';

class TechnologyChat extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(
      
      ),
      body: Container(
        child: Text("Technology"),
      ),
    );
  }
}
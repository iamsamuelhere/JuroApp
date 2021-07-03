import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/components/AppBar.dart';
import 'package:newsapp/service/GoogleAuth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../authScreen.dart';

class BusinessChat extends StatelessWidget {
   UserCredential user;
   BusinessChat({this.user});

  @override
  Widget build(BuildContext context) {
    return Container(
       child:Text(user.toString())
    );
  }
}
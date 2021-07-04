import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Data extends ChangeNotifier {
  UserCredential userc;
  ThemeData mode= ThemeData.light();
  IconData modeIcon=Icons.nightlight_round;

  void updateUserCredential(UserCredential user) {
    userc = user;
    notifyListeners();
  }

  void updateMode(){
     if(mode==ThemeData.light()){
       mode=ThemeData.dark();
       modeIcon=Icons.lightbulb_outline;
     }
     else{
       mode=ThemeData.light();
       modeIcon=Icons.nightlight_round;
     }
     notifyListeners();
  }
}

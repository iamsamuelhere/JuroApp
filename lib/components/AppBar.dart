

import 'package:flutter/material.dart';

Widget appBar([List actions]){

  return     AppBar(
        centerTitle: true,
        actions:actions,
        title:Text("NewsApp"));
        
}


import 'package:flutter/material.dart';

Widget appBar({List<Widget> actions}){

  return     AppBar(
        centerTitle: true,
        actions:actions,
        title:Text("NewsApp"));
        
}
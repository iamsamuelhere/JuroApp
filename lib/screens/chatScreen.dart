import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'chat tab/Chat topic Screens/business.dart';
import 'chat tab/Chat topic Screens/entertainment.dart';
import 'chat tab/Chat topic Screens/health.dart';
import 'chat tab/Chat topic Screens/science.dart';
import 'chat tab/Chat topic Screens/sports.dart';
import 'chat tab/Chat topic Screens/technology.dart';

class ChatScreen extends StatelessWidget {
UserCredential userc;
ChatScreen({this.userc});
var topic=[
  {
   "topic":"Business",
   "screen":BusinessChat(),
},
  {
   "topic":"Entertainment",
   "screen":EntertainmentChat(),
},
  {
   "topic":"Health",
   "screen":HealthChat(),
},
  {
   "topic":"Science",
   "screen":ScienceChat(),
},
  {
   "topic":"Sports",
   "screen":SportsChat(),
},
  {
   "topic":"Technology",
   "screen":TechnologyChat(),
},
];



  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(
    actions: [
      Container(
        margin:EdgeInsets.all(5),
        child: ClipOval(
      
          child: Image(
            image: NetworkImage(userc.additionalUserInfo.profile['picture']),
          ),
        ),
      ),
      Container(
        margin: EdgeInsets.only(left:2,right: 5),
        child: IconButton(
          onPressed: (){

          },
          icon:Icon(Icons.exit_to_app)
        
        ),
        )
    ],
  ),

    body:ListView(
     
      children: topic.map((e) => ChatCategory(
        screen: (){Navigator.push(context, MaterialPageRoute(
        builder: (context)=>e['screen'])
        );
        },
        title: e['topic'],),).toList()
      
  
      
       )
  
      
    );
  }
}

class ChatCategory extends StatelessWidget {
  Function screen;
  String title;
ChatCategory({this.screen,this.title});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap:screen ,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal:40,vertical: 10),
      child: Card(
        elevation: 5,
        child: Container(
        
        margin: EdgeInsets.all(25.0),
        padding: EdgeInsets.all(25.0),
        child: Align(
          alignment: Alignment.center,
          child: Text(title,style:TextStyle(fontSize: 25.0,fontWeight: FontWeight.bold) ,))),),
    ),
      );
  }
}

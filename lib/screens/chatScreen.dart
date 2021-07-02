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
   "image":"images/topicschat/business.jpg",
   "screen":BusinessChat(),
},
  {
   "topic":"Entertainment",
   "image":"images/topicschat/business.jpg",

   "screen":EntertainmentChat(),
},
  {
   "topic":"Health",
   "image":"images/topicschat/business.jpg",

   "screen":HealthChat(),
},
  {
   "topic":"Science",
   "image":"images/topicschat/business.jpg",

   "screen":ScienceChat(),
},
  {
   "topic":"Sports",
   "image":"images/topicschat/business.jpg",

   "screen":SportsChat(),
},
  {
   "topic":"Technology",
   "image":"images/topicschat/business.jpg",

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
     
      // children: topic.map((e) => ChatCategory(
      //   image:e['image'],
      //   screen: (){Navigator.push(context, MaterialPageRoute(
      //   builder: (context)=>e['screen'])
      //   );
      //   },
      //   title: e['topic'],),).toList()

      children:[
        Text("a")
      ]
      
  
      
       )
  
      
    );
  }
}

class ChatCategory extends StatelessWidget {
  Function screen;
  String title;
  String image;
ChatCategory({this.screen,this.title,this.image});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
    onTap:screen ,
    child: Container(
      margin: EdgeInsets.symmetric(horizontal:40,vertical: 10),
      child: Card(
        elevation: 5,
        child: Image(
          width: 100.0,height:100.0,
          image:AssetImage(image))),
    ),
      );
  }
}

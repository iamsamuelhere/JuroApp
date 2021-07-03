import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/screens/favouriteSceen.dart';
import 'package:newsapp/screens/feedScreen.dart';
import 'package:newsapp/service/GoogleAuth.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'chat tab/Chat topic Screens/business.dart';
import 'chat tab/Chat topic Screens/entertainment.dart';
import 'chat tab/Chat topic Screens/health.dart';
import 'chat tab/Chat topic Screens/science.dart';
import 'chat tab/Chat topic Screens/sports.dart';
import 'chat tab/Chat topic Screens/technology.dart';

class ChatScreen extends StatefulWidget {
  UserCredential userc;
  ChatScreen({this.userc});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  var topic = [
    {
      "topic": "Business",
      "image": "images/topicschat/business.jpg",
      "screen": BusinessChat(user: userc),
    },
    {
      "topic": "Entertainment",
      "image": "images/topicschat/entertainment.jpg",
      "screen": EntertainmentChat(),
    },
    {
      "topic": "Health",
      "image": "images/topicschat/health.jpg",
      "screen": HealthChat(),
    },
    {
      "topic": "Science",
      "image": "images/topicschat/science.jpg",
      "screen": ScienceChat(),
    },
    {
      "topic": "Sports",
      "image": "images/topicschat/sports.jpg",
      "screen": SportsChat(),
    },
    {
      "topic": "Technology",
      "image": "images/topicschat/technology.jpg",
      "screen": TechnologyChat(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    if (widget.userc.additionalUserInfo.isNewUser == true)
      Future.delayed(Duration.zero, () => dialog(context));

    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            margin: EdgeInsets.all(5),
            child: ClipOval(
              child: Image(
                image: NetworkImage(
                    widget.userc.additionalUserInfo.profile['picture']),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 2, right: 5),
            child: IconButton(
                onPressed: () {
                  googleSignout();
                  Navigator.pop(context);
                  Fluttertoast.showToast(msg: "Logged out");
                },
                icon: Icon(Icons.exit_to_app)),
          )
        ],
      ),
 

     body: ListView.builder(
        itemCount: topic.length,
        itemBuilder: (BuildContext context, int index) {
        return    GestureDetector(
          onTap:(){
              Navigator.push(context,MaterialPageRoute(builder: (context)=>topic[index]['screen']));
          }, 
        
          child: Card(
              elevation: 30.0,
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Stack(alignment: Alignment.center, children: [
                Image(
                  fit: BoxFit.fill,
                  height: 200.0,
                  width: double.infinity,
                  image: AssetImage(topic[index]['image']),
                ),
                Opacity(
                    opacity: 0.7,
                    child: Container(
                      height: 200.0,
                      color: Colors.black54,
                    )),
                Text(
                  topic[index]['topic'],
                  style: TextStyle(
                      fontSize: 50.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w100,
                      letterSpacing: 4.0),
                ),
              ]),
            ),
        );
       },
      ),

   
    );
  }

  void dialog(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              "Guidelines",
              textAlign: TextAlign.center,
            ),
            content: Column(mainAxisSize: MainAxisSize.min, children: [
              Text("Welcome ${widget.userc.user.displayName}"),
              Text("Rules to follow")
            ]),
          );
        });
  }
}


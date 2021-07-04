import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:newsapp/components/AppBar.dart';
import 'package:newsapp/service/DataProvider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:newsapp/service/GoogleAuth.dart';
import 'package:provider/provider.dart';

import '../authScreen.dart';

class BusinessChat extends StatefulWidget {
  @override
  _BusinessChatState createState() => _BusinessChatState();
}

class _BusinessChatState extends State<BusinessChat> {
  final Query<Map<String, dynamic>> _usersStream = FirebaseFirestore.instance
      .collection('BusinessChats')
      .orderBy('date', descending: true);
  CollectionReference msg =
      FirebaseFirestore.instance.collection("BusinessChats");
  bool isme = false;

  TextEditingController chatmsg = TextEditingController();

  @override
  Widget build(BuildContext context) {
    UserCredential userc = Provider.of<Data>(context).userc;

    sendmsg() async {
      await msg.add({
        "Name": userc.user.displayName,
        "msg": chatmsg.text,
        "photo": userc.user.photoURL,
        "uid": userc.user.uid,
        "date": DateTime.now()
      }).then((value) => {print("Added")});
    }

    return Scaffold(
      appBar: AppBar(
        title: Text("Chat"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder(
              stream: _usersStream.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.data != null) {
                  return ListView.builder(
                      reverse: true,
                      itemCount: snapshot.data.docs.length,
                      itemBuilder: (context, index) {
                        DocumentSnapshot doc =
                            snapshot.data.docs[index]; // for querys
                        if (doc["uid"] == userc.user.uid) {
                          isme = true;
                        } else {
                          isme = false;
                        }
                        return (snapshot.data != null)
                            ? Row(
                                mainAxisAlignment: isme
                                    ? MainAxisAlignment.end
                                    : MainAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: isme
                                          ? CrossAxisAlignment.end
                                          : CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: EdgeInsets.all(8),
                                          decoration: isme
                                              ? BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(0),
                                                    topLeft:
                                                        Radius.circular(20),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                  ),
                                                  color: isme
                                                      ? Colors.red
                                                      : Colors.blue,
                                                )
                                              : BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.only(
                                                    bottomRight:
                                                        Radius.circular(20),
                                                    topLeft: Radius.circular(0),
                                                    topRight:
                                                        Radius.circular(20),
                                                    bottomLeft:
                                                        Radius.circular(20),
                                                  ),
                                                  color: isme
                                                      ? Colors.red
                                                      : Colors.blue,
                                                ),
                                          child: Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "${doc['msg']}",
                                                    style: TextStyle(
                                                        fontSize: 20.0),
                                                  ),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  CircleAvatar(
                                                      radius: 15,
                                                      backgroundImage:
                                                          NetworkImage(
                                                              doc['photo'])),
                                                  SizedBox(
                                                    height: 5.0,
                                                  ),
                                                  Text(
                                                    "- ${doc['Name']}",
                                                    style: TextStyle(
                                                        fontSize: 10.0,
                                                        fontWeight:
                                                            FontWeight.w800,
                                                        color: Colors.white),
                                                  ),
                                                ],
                                              )),
                                        ),
                                      ],
                                    ),
                                  ),
                                  isme
                                      ? IconButton(
                                          icon: Icon(Icons.delete,
                                              color: Colors.red[400]),
                                          onPressed: () {
                                            doc.reference.delete();
                                          })
                                      : Text("")
                                ],
                              )
                            : Text("a");
                      });
                } else
                  return Text("no data");
              },
            ),
          ),
          //bottom textbar
          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(userc.user.photoURL)),
                ),
                SizedBox(width: 5),
                Expanded(
                  flex: 6,
                  child: TextFormField(
                    controller: chatmsg,
                    minLines: 1,
                    maxLines: 4,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                      hintText: "Send message...",
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 5),
                Expanded(
                    child: CircleAvatar(
                  radius: 30,
                  child: IconButton(
                      icon: Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        sendmsg();
                        chatmsg.clear();
                      }),
                  backgroundColor: Colors.green,
                ))
              ],
            ),
          )
        ],
      ),
    );
  }
}

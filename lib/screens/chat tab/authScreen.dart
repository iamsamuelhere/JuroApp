import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/components/AppBar.dart';

import 'package:newsapp/screens/chatScreen.dart';
import 'package:newsapp/service/GoogleAuth.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fluttertoast/fluttertoast.dart';



UserCredential userc;


class AuthScreen extends StatefulWidget {
  

  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          
          children: [
            Text("Auth with Google"),
            ElevatedButton(onPressed:()async{

               userc= await signInWithGoogle();
               if(userc!=null){
                 print(userc.additionalUserInfo.profile);
                
               Fluttertoast.showToast(msg:"SignedIn as : ");
                   pushNewScreen(
        context,

        screen: ChatScreen(
         userc: userc,
        ),

        withNavBar: true, // OPTIONAL VALUE. True by default.
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
    );

                 
               }
                 
           
              }
            , child:Text("Continue with Google"),),
            if(userc!=null)Text("${userc.additionalUserInfo.isNewUser}"),
            IconButton(icon: Icon(Icons.follow_the_signs), onPressed:googleSignout)
          ],
        ),
      )

      
    );
  }
}
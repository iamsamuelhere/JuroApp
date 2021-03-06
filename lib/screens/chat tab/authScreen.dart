import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/components/AppBar.dart';

import 'package:newsapp/screens/chatScreen.dart';
import 'package:newsapp/service/DataProvider.dart';
import 'package:newsapp/service/GoogleAuth.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

UserCredential userc;

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: appBar(), body: LoginScreen());
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("------------------------------------------");
    print(Provider.of<Data>(context).userc);
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
       
          ElevatedButton(
            onPressed: () async {
              userc = await signInWithGoogle();
              if (userc != null) {
                print(userc.additionalUserInfo.profile);

                Provider.of<Data>(context, listen: false)
                    .updateUserCredential(userc);

                Fluttertoast.showToast(
                    msg: "SignedIn as : ${userc.user.email}");
                pushNewScreen(
                  context,

                  screen: ChatScreen(),

                  withNavBar: true, // OPTIONAL VALUE. True by default.
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              }
            },
            child: Text("Continue with Google"),
          ),
             (userc != null) ? Text(userc.user.email,style: TextStyle(color: Colors.grey),) : Text(""),
          IconButton(
              icon: Icon(Icons.follow_the_signs),
              onPressed: () {
                googleSignout();
              }),
        ],
      ),
    );
  }
}

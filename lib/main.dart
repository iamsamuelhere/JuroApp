import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:newsapp/screens/chat%20tab/authScreen.dart';
import 'package:newsapp/screens/chatScreen.dart';

import 'package:newsapp/screens/favouriteSceen.dart';
import 'package:newsapp/screens/feedScreen.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
  
   routes: {
    '/ch': (context) => chScreen(),

  },
    
    
    
    home: MyApp()));
}        


class MyApp extends StatelessWidget {

  PersistentTabController _controller= PersistentTabController(initialIndex: 0);
  @override
  Widget build(BuildContext context) {
      return
       PersistentTabView(
              context,
              controller: _controller,
              screens: _screens(),
              items: _navBarsItems(),
              confineInSafeArea: true,
              backgroundColor: Colors.white, // Default is Colors.white.
              handleAndroidBackButtonPress: true, // Default is true.
              resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
              stateManagement: true, // Default is true.
              hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
              decoration: NavBarDecoration(
                borderRadius: BorderRadius.circular(10.0),
                colorBehindNavBar: Colors.white,
              ),
              popAllScreensOnTapOfSelectedTab: true,
              popActionScreens: PopActionScreensType.all,
              itemAnimationProperties: ItemAnimationProperties( // Navigation Bar's items animation properties.
                duration: Duration(milliseconds: 200),
                curve: Curves.ease,
              ),
              screenTransitionAnimation: ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
                animateTabTransition: true,
                curve: Curves.ease,
                duration: Duration(milliseconds: 200),
              ),
              navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
          );
       
     
    
  }
}
    List<PersistentBottomNavBarItem> _navBarsItems() {
        return [
            PersistentBottomNavBarItem(
                icon: Icon(Icons.home),
                title: ("Home"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),
            PersistentBottomNavBarItem(
                icon: Icon(Icons.chat),
                title: ("Chat"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),
                  PersistentBottomNavBarItem(
                icon: Icon(Icons.favorite),
                title: ("Favourite"),
                activeColorPrimary: Colors.blue,
                inactiveColorPrimary: Colors.grey,
            ),
        ];
    }



    List<Widget> _screens() {
        return [
          FeedScreen(),
    AuthScreen(),
    FavouriteScreen()
        ];
    }







// class BottomBar extends StatefulWidget {

//   @override
//   _BottomBarState createState() => _BottomBarState();
// }



// class _BottomBarState extends State<BottomBar> {
//   int _curIndex=0;
//   void changeIndex(int index){
//     setState(() {
//           _curIndex=index;
//         });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
      
//       appBar: AppBar(title: Text("News App"),),
//       body:screens[_curIndex],
//       bottomNavigationBar: BottomNavigationBar(
//         currentIndex: _curIndex,
//         onTap: changeIndex,
//         selectedItemColor: Colors.red,
        
//         items: [
//         BottomNavigationBarItem(

//           label: 'Feed',
//           icon: Icon(Icons.pause_presentation
        
//         )),
//             BottomNavigationBarItem(
              
//           label: 'Chat',
//           icon: Icon(Icons.chat
        
//         )),
//             BottomNavigationBarItem(
//           label: 'Feed',
//           icon: Icon(Icons.favorite
        
//         )),
      
//       ]),
//     );
//   }
// }



class chScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Text("ch")
      
    );
  }
}
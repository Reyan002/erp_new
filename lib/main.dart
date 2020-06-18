import 'package:abbasigroup/Screens/LoginActivity.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash/animated_splash.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'Screens/Home.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  String emailPref=null;

   @override
  Widget build(BuildContext context) {
   CheckLogin();
    return MaterialApp(

      home: Stack(
        children: <Widget>[
          AnimatedSplash(
            imagePath: "assets/images/fulllogo.png",
            duration: 3000,
            home:  emailPref == null ? LoginActivity() : Home(),
            type: AnimatedSplashType.StaticDuration,
          ),


        ],
      )
    );
  }
 void CheckLogin() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    var email = prefs.getString('email');
    print(email);
      emailPref=email;
  }
}

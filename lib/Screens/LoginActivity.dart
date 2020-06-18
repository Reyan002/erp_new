import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'SelectCountry.dart';
import 'package:shared_preferences/shared_preferences.dart';
 class LoginActivity extends StatefulWidget {
  @override
  _LoginActivityState createState() => _LoginActivityState();
}

class _LoginActivityState extends State<LoginActivity> {
  VideoPlayerController _controller;
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String _username='';
  String _password='';
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // Pointing the video controller to our local asset.
    _controller = VideoPlayerController.asset("assets/video/backvideo.mp4")
      ..initialize().then((_) {
        // Once the video has been loaded we play the video and set looping to true.
        _controller.play();
        _controller.setLooping(true);
        // Ensure the first frame is shown after the video is initialized.
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // BoxFit.fill created the look I was going for.

        // Adjusted theme colors to match logo.
        primaryColor: Color(0xff2a5298),
        accentColor: Colors.white,
      ),
      home: SafeArea(
        child: Scaffold(
          // TODO 6: Create a Stack Widget
          body: Builder(
            builder: (context) =>
                Stack(
              children: <Widget>[
                // TODO 7: Add a SizedBox to contain our video.

                SizedBox.expand(
                  child: FittedBox(
                    // If your background video doesn't look right, try changing the BoxFit property.
                    fit: BoxFit.fill,
                    child: SizedBox(
                      width: _controller.value.size?.width ?? 0,
                      height: _controller.value.size?.height ?? 0,
                      child: VideoPlayer(_controller),
                    ),
                  ),
                ),
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    child: Center(),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  Container(
                    decoration: new BoxDecoration(
                      color: Colors.white.withAlpha(200),
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(10.0),
                        topRight: const Radius.circular(10.0),
                        bottomLeft: const Radius.circular(10.0),
                        bottomRight: const Radius.circular(10.0),
                      ),
                    ),
                    padding: EdgeInsets.all(16),
                    margin: EdgeInsets.all(20),
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        TextFormField(
                            validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter User Name';
                            }
                            return null;
                          },
                   onSaved: (value){
                    _username=value;
                  },
                          cursorColor: Color(0xff2a5298),
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                          decoration: InputDecoration(
                              hintText: 'Username',

                              icon: Icon(
                                Icons.account_circle,
                                size: 30,
                              )),
                        ),
                        TextFormField(
                          obscureText: true,
                           validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter Password';
                            }
                            return null;
                          },
                   onSaved: (value){
                    _password=value;
                  },
//                          controller: passwordController,
                          cursorColor: Color(0xff2a5298),
                          style: TextStyle(
                            fontSize: 24.0,
                          ),
                          decoration: InputDecoration(
                              hintText: 'Password',

                              icon: Icon(
                                Icons.vpn_key,
                                size: 30,
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(top: 20),
                          child: ButtonTheme(
                            minWidth: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: RaisedButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ),
                              color: Color(0xff2a5298),
                              child: Text(
                                'Login',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                ),
                              ),
                              onPressed: () async{

                                if(_formKey.currentState.validate()){
                                  _formKey.currentState.save();

                                  if(_username=='admin'&&_password=="admin"){
                                    SharedPreferences prefs = await SharedPreferences.getInstance();
                                    prefs.setString('email', _username);

                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => SelectCompany()),
                                    );
                                  }
                                  else{
                                    Scaffold.of(context)
                                        .showSnackBar(SnackBar(content: Text("Error in Credentials try Again")));
                                  }



                                }
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

                Container(
                  padding: EdgeInsets.all(30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Image.asset("assets/images/fulllogo.png"),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,

                  children: <Widget>[
                    Container(
                        width: 75,
                        height: 50,
                        child: Image.asset("assets/images/wedes.png")
                    ),
                    Text(
                      "Copyright 2019 ICT Information Systems LLC, All Right Reserved",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }


}



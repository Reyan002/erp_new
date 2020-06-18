import 'package:abbasigroup/Classes/DrawerItems.dart';
import 'package:abbasigroup/Fragments/Dashboard.dart';
import 'package:abbasigroup/Fragments/HomeFragment.dart';

import 'package:abbasigroup/Screens/LoginActivity.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Home extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Home", Icons.home),
    new DrawerItem("Dashboard", Icons.dashboard),
    new DrawerItem("Profile", Icons.account_circle),
    new DrawerItem("Logout", Icons.arrow_back),
    new DrawerItem("Accounts", Icons.recent_actors),
    new DrawerItem("FeedBack", Icons.feedback),
    new DrawerItem("E Transaction History", Icons.history),
    new DrawerItem("Settings", Icons.settings),
    new DrawerItem("Terms and Conditions", Icons.error),

  ];
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedDrawerIndex = 0;

  _getDrawerItemWidget(int pos)  {
    switch (pos) {
      case 0:
        return new HomePage();
      case 1:
        return new MyHomePage();

      default:
        return new Text("Error");
    }

  }

  _onSelectItem(int index) {
    setState(() => _selectedDrawerIndex = index);
    Navigator.of(context).pop(); // close the drawer
  }
  @override
  Widget build(BuildContext context) {
    var drawerOptions = <Widget>[];
    for (var i = 0; i < widget.drawerItems.length; i++) {
      var d = widget.drawerItems[i];
      drawerOptions.add(
          new ListTile(
            leading: new Icon(d.icon),
            title: new Text(d.title),
            selected: i == _selectedDrawerIndex,
            onTap: () => _onSelectItem(i),
          )
      );
    }

    return WillPopScope(
      onWillPop: _onBackPressed,
      child: new Scaffold(
        appBar: new AppBar(
          // here we display the title corresponding to the fragment
          // you can instead choose to have a static title
          title: new Text(widget.drawerItems[_selectedDrawerIndex].title),
        ),
        drawer: Container(
          color: Colors.black45,

          width: 400,
          child: new Drawer(
            child: new Column(
              children: <Widget>[
                new UserAccountsDrawerHeader(
                    accountName: new Text("Abbasi Group of Companies"), accountEmail: new Text("EMP-101234"),currentAccountPicture: CircleAvatar(backgroundImage:NetworkImage('https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500') ),),
                new Column(children: drawerOptions)
              ],
            ),
          ),
        ),
        body: _getDrawerItemWidget(_selectedDrawerIndex),
      ),
    );


  }

  void logout(){

  }
  Future<bool> _onBackPressed() {
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
  }
}


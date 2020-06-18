import 'package:abbasigroup/Classes/Users.dart';
import 'package:abbasigroup/Export/Schedules/SearchResult.dart';
import 'package:abbasigroup/Fragments/Export.dart';
import 'package:abbasigroup/models/newsArticle.dart';
import 'package:abbasigroup/services/webservice.dart';
import 'package:flutter/material.dart';
import 'package:expandable/expandable.dart';
  import 'package:http/http.dart' as http;
import 'dart:convert';

class PointToPoint extends StatefulWidget {

  const PointToPoint({ Key key, this.destination }) : super(key: key);

  final Destination destination;

  @override
  _PointToPointState createState() => _PointToPointState();
}

class _PointToPointState extends State<PointToPoint> {
  Users _currentUser;
  Future<List<Users>> _tagList;
  final String uri = 'https://jsonplaceholder.typicode.com/users';
  String radioItem = '';
  final List<String> names = <String>[
    'Aby',
    'Aish',
    'Ayan',
    'Ben',
    'Bob',
    'Charlie',
    'Cook',
    'Cook',
    'Cook',
    'Cook',
    'Carline'
  ];

  List<NewsArticle> _newsArticles = List<NewsArticle>();

  bool pressAttention=false;



  @override
  void initState() {
    super.initState();
    _tagList = _fetchUsers();
  }




  Future<List<Users>> _fetchUsers() async {
    var response = await http.get(uri);

    if (response.statusCode == 200) {
      final items = json.decode(response.body).cast<Map<String, dynamic>>();
      List<Users> listOfUsers = items.map<Users>((json) {
        return Users.fromJson(json);
      }).toList();

      return listOfUsers;
    } else {
      throw Exception('Failed to load internet');
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: Column(children: <Widget>[
Padding(
  padding: EdgeInsets.fromLTRB(0.0, 8, 0.0, 10.0),
  child:   Card(

    elevation: 12,
    child: Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
          child: Container(

            child: Text("From(City, Country/Region)",textAlign: TextAlign.start,),
            width: double.infinity,
          ),
        ),
        Container(
          child: Padding(
            padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 10.0),
            child: Container(
              decoration: BoxDecoration(border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[
                  new FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.location_on),
                    label: Text(""),
                  ),
                  FutureBuilder<List<Users>>(
                      future: _tagList,
                      builder: (BuildContext context,
                          AsyncSnapshot<List<Users>> snapshot) {
                        if (!snapshot.hasData)
                          return CircularProgressIndicator(
                            backgroundColor: Colors.indigo,
                          );
                        return DropdownButton<Users>(
                          underline: SizedBox(),
                          items: snapshot.data
                              .map((user) => DropdownMenuItem<Users>(
                            child: Text(user.name),
                            value: user,
                          ))
                              .toList(),
                          onChanged: (Users value) {
                            setState(() {
                              _currentUser = value;
                            });
                          },
                          value: _currentUser,
                          isExpanded: false,
                          //value: _currentUser,
                          hint: Text( 'City, Country/Region'),
                        );
                      }),
                ],
              ),
            ),
          ),
        ),

        Padding(
          padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 10.0),
          child: Row(
            children: <Widget>[
          Expanded(
            child: new RaisedButton(
            child: new Text('Merchant CY'),
      textColor: Colors.white,
      shape: new RoundedRectangleBorder(
            borderRadius: new BorderRadius.circular(30.0),
      ),
      color: pressAttention ? Colors.grey : Colors.blue,
      onPressed: () => setState(() => pressAttention = !pressAttention),
    ),
          ),
              Expanded(
                child: new RaisedButton(

                  child: new Text('Carrier SD'),
                  textColor: Colors.white,
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                  color: pressAttention ? Colors.blue : Colors.grey,
                  onPressed: () => setState(() => pressAttention = !pressAttention),
                ),
              ),
//              Text(
//                '$radioItem',
//                style: TextStyle(fontSize: 23),
//              )
            ],
          ),
        ),
      ],
    ),
  ),
),
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 8, 0.0, 10.0),
            child:   Card(

              elevation: 12,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                    child: Container(

                      child: Text("To(City, Country/Region)",textAlign: TextAlign.start,),
                      width: double.infinity,
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(border: Border.all(color: Colors.black)),
                        child: Row(
                          children: <Widget>[
                            new FlatButton.icon(
                              onPressed: () {},
                              icon: Icon(Icons.location_on),
                              label: Text(""),
                            ),
                            FutureBuilder<List<Users>>(
                                future: _tagList,
                                builder: (BuildContext context,
                                    AsyncSnapshot<List<Users>> snapshot) {
                                  if (!snapshot.hasData)
                                    return CircularProgressIndicator(
                                      backgroundColor: Colors.indigo,
                                    );
                                  return DropdownButton<Users>(
                                    underline: SizedBox(),
                                    items: snapshot.data
                                        .map((user) => DropdownMenuItem<Users>(
                                      child: Text(user.name),
                                      value: user,
                                    ))
                                        .toList(),
                                    onChanged: (Users value) {
                                      setState(() {
                                        _currentUser = value;
                                      });
                                    },
                                    value: _currentUser,
                                    isExpanded: false,
                                    //value: _currentUser,
                                    hint: Text( 'City, Country/Region'),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 10.0),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: new RaisedButton(
                            child: new Text('Merchant CY'),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: pressAttention ? Colors.grey : Colors.blue,
                            onPressed: () => setState(() => pressAttention = !pressAttention),
                          ),
                        ),
                        Expanded(
                          child: new RaisedButton(

                            child: new Text('Carrier SD'),
                            textColor: Colors.white,
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                            color: pressAttention ? Colors.blue : Colors.grey,
                            onPressed: () => setState(() => pressAttention = !pressAttention),
                          ),
                        ),
//              Text(
//                '$radioItem',
//                style: TextStyle(fontSize: 23),
//              )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

      ListTile(
        title: Text("Advanced Search"),
         leading: Icon(Icons.expand_more),
      ),

      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: double.infinity,
          child: RaisedButton(
            child: Text("Search",style: TextStyle(color: Colors.white),),
            color: Color(0xff2a5298),
            onPressed: (){

              Navigator.pushNamed(context, "/list");

            },
          ),
        ),
      ),

    ]
        )
    );
  }
}

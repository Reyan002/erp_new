import 'package:abbasigroup/models/newsArticle.dart';
import 'package:abbasigroup/services/webservice.dart';
import 'package:abbasigroup/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:abbasigroup/Classes/Users.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; //for date format



class PortCalls extends StatefulWidget {

  @override
  _PortCallsState createState() => _PortCallsState();
}

class _PortCallsState extends State<PortCalls> {
  Users _currentUser;
  Future<List<Users>> _tagList ;
  List<NewsArticle> _newsArticles = List<NewsArticle>();

  @override
  void initState() {
    super.initState();
    _populateNewsArticles();
    _tagList=_fetchUsers();

  }

  void _populateNewsArticles() {

    Webservice().load(NewsArticle.all).then((newsArticles) => {
      setState(() => {
        _newsArticles = newsArticles
      })
    });

  }

  Card _buildItemsForListView(BuildContext context, int index) {
//    return ListTile(
//      title: _newsArticles[index].urlToImage == null ? Image.asset(Constants.NEWS_PLACEHOLDER_IMAGE_ASSET_URL) : Image.network(_newsArticles[index].urlToImage),
//      subtitle: Text(_newsArticles[index].title, style: TextStyle(fontSize: 18)),
//
  return new Card(
    child: Column(
      children: <Widget>[

        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
             child: FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.schedule), label: Text("Vessel Schedule",style: TextStyle(fontSize: 20),)),
          ),
        ),

        Row(
          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.directions_boat), label: Text("")),
            Expanded(child: Text("Vessel/Voyage")),
            Expanded(child: Text(_newsArticles[index].author)),
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.local_shipping), label: Text("")),
            Expanded(child: Text("Terminal")),
            Expanded(child: Text("Karachi PICT Terminal")),
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.location_on), label: Text("")),
            Expanded(child: Text("Arrival")),
            Expanded(child: Text("8 june 2020 17:00")),
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.location_on), label: Text("")),
            Expanded(child: Text("Departure")),
            Expanded(child: Text("8 june 2020 17:00")),
          ],
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.timelapse), label: Text("Deadlines",style: TextStyle(fontSize: 20),)),
          ),
        ),
        Row(
          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.access_time), label: Text("")),

            Expanded(child: Text("CY")),
            Expanded(child: Text("8 june 2020 17:00")),
          ],
        ),
        Row(

          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.access_time), label: Text("")),

            Expanded(child: Text("SI - NON AMS")),
            Expanded(child: Text("8 june 2020 17:00")),
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.access_time), label: Text("")),

            Expanded(child: Text("SI - AMS")),
            Expanded(child: Text("8 june 2020 17:00")),
          ],
        ),
        Row(
          children: <Widget>[
            FlatButton.icon(onPressed: ( ){}, icon: Icon(Icons.access_time), label: Text("")),

            Expanded(child: Text("VGM")),
            Expanded(child: Text("8 june 2020 17:00")),
          ],
        ),
//        Row(
//          children: <Widget>[
//            Expanded(child: Text("SI - AMS")),
//            Expanded(child: Text("8 june 2020 17:00")),
//
//            Row(
//              children: <Widget>[
//                Expanded(child: Text("VGM")),
//                Expanded(child: Text("8 june 2020 17:00")),
//              ],
//            ),
//          ],
//        ),
      ],
    ),


  );
  }
  final String uri = 'https://jsonplaceholder.typicode.com/users';
  var finaldate;
  final f = new DateFormat('yyyy-MM-dd');
  void callDatePicker() async {
    var order = await getDate();
    setState(() {
      finaldate = order;
    });
  }

  Future<DateTime> getDate() {
    // Imagine that this function is
    // more complex and slow.
    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2018),
      lastDate: DateTime(2030),
      builder: (BuildContext context, Widget child) {
        return Theme(
          data: ThemeData.light(),
          child: child,
        );
      },
    );
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

      body: Column(
        children: <Widget>[
          Container(
            child: Padding(
              padding : EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),

              child: Container(
                decoration: BoxDecoration( border: Border.all(color: Colors.black)),

                child: Row(
                  children: <Widget>[
                    new FlatButton.icon(
                      onPressed:  (){

                      },
                      icon: Icon(Icons.location_on),
                      label: Text(""),
                    ),
                    FutureBuilder<List<Users>>(
                        future: _tagList,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Users>> snapshot) {
                          if (!snapshot.hasData) return CircularProgressIndicator(
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
                            hint: Text('Select Country'),

                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding : EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),

              child: Container(
                decoration: BoxDecoration( border: Border.all(color: Colors.black)),

                child: Row(
                  children: <Widget>[
                    new FlatButton.icon(
                      onPressed:  (){

                      },
                      icon: Icon(Icons.location_on),
                      label: Text(""),
                    ),
                    FutureBuilder<List<Users>>(
                        future: _tagList,
                        builder: (BuildContext context,
                            AsyncSnapshot<List<Users>> snapshot) {
                          if (!snapshot.hasData) return CircularProgressIndicator(
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
                            hint: Text('Select City'),

                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding : EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),

            child: Container(


              decoration: BoxDecoration( border: Border.all(color: Colors.black)),
              child: Row(
                children: <Widget>[


                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new FlatButton.icon(
                        onPressed: callDatePicker,
                        icon: Icon(Icons.date_range),
                        label: Text(""),

                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                       decoration: BoxDecoration(color: Colors.white, ),

                      child: finaldate == null
                          ? Text(
                        "Select Date",
                        style: TextStyle(fontSize: 16,color: Colors.grey),
                      )

                          : Text(
                        "${DateFormat.yMMMd().format(finaldate)}",
                        style: TextStyle(fontSize: 16),

                      ),
                    ),
                  ),

                ],
              ),
            ),
          ),
          Padding(

            padding: const EdgeInsets.only(right: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                RaisedButton(
                   textColor: Colors.white,
                  color: Color(0xff2a5298),
                   child: Text("Search"),
                  onPressed: (){},
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _newsArticles.length,
              itemBuilder: _buildItemsForListView,
            ),
          )
        ],
      ),
    );

  }

}



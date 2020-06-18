import 'package:abbasigroup/Fragments/Export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; //for date format

import 'package:abbasigroup/Classes//data.dart';
import 'package:http/http.dart' as http;
import 'package:abbasigroup/Classes/user.dart';
import 'dart:convert';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

class VesselSchedule extends StatefulWidget {

  @override
  _VesselScheduleState createState() => _VesselScheduleState();
}

class _VesselScheduleState extends State<VesselSchedule> {
  AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<User>> key = new GlobalKey();
  static List<User> users = new List<User>();
  bool loading = true;

  void getUsers() async {
    try {
      final response =
          await http.get("https://jsonplaceholder.typicode.com/users");
      if (response.statusCode == 200) {
        users = loadUsers(response.body);
        print('Users: ${users.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting users.");
      }
    } catch (e) {
      print("Error getting users.");
    }
  }

  static List<User> loadUsers(String jsonString) {
    final parsed = json.decode(jsonString).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  Widget row(User user) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            user.name,
            style: TextStyle(fontSize: 18.0),
          ),
        ),
//        SizedBox(
//          width: 10.0,
//        ),
//        Text(
//          user.email,
//        ),
      ],
    );
  }

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


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Stack(
        children: <Widget>[


          Column(

            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration( border: Border.all(color: Colors.black)),

                  child: Stack(
                    children: <Widget>[
                      Column(
                        children: <Widget>[
                          loading
                              ? CircularProgressIndicator()
                              : searchTextField = AutoCompleteTextField<User>(
                            key: key,
                            clearOnSubmit: false,
                            suggestions: users,
                            style: TextStyle(color: Colors.black, fontSize: 18.0),
                            decoration: InputDecoration(
                              contentPadding:
                              EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 20.0),
                              hintText: "Vessel Name",
                              hintStyle: TextStyle(color: Colors.grey),
                            ),
                            itemFilter: (item, query) {
                              return item.name
                                  .toLowerCase()
                                  .startsWith(query.toLowerCase());
                            },
                            itemSorter: (a, b) {
                              return a.name.compareTo(b.name);
                            },
                            itemSubmitted: (item) {
                              setState(() {
                                searchTextField.textField.controller.text =
                                    item.name;
                              });
                            },
                            itemBuilder: (context, item) {
                              // ui for the autocompelete row
                              return row(item);
                            },
                          ),
                        ],
                      ),
                      Center(

                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: new FlatButton.icon(
                                onPressed:  (){

                                },
                                icon: Icon(Icons.directions_boat),
                                label: Text(""),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
             Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(


                  decoration: BoxDecoration( border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(color: Colors.white, ),

                            child: finaldate == null
                                ? Text(
                              "Select Date",
                              style: TextStyle(fontSize: 18,color: Colors.grey),
                            )

                                : Text(
                              "${DateFormat.yMMMd().format(finaldate)}",
                              style: TextStyle(fontSize: 18),

                            ),
                          ),
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            new FlatButton.icon(
                              onPressed: callDatePicker,
                              icon: Icon(Icons.date_range),
                              label: Text(""),

                            ),
                          ],
                        )
                      ],
                    ),
                  ),
               ),
             ),


              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  elevation: 10,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("Vessel Information",style: TextStyle(fontSize: 24),),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Botany Bay",style: TextStyle(fontSize: 20),),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text("TEU (Nominal)",style: TextStyle(fontSize: 16),)),
                              Expanded(child: Text("2646.0000000000 ",style: TextStyle(fontSize: 16),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text("Built",style: TextStyle(fontSize: 16),)),
                              Expanded(child: Text("-",style: TextStyle(fontSize: 16),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text("IMO Number",style: TextStyle(fontSize: 16),)),
                              Expanded(child: Text("9334519",style: TextStyle(fontSize: 16),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text("Call Sign",style: TextStyle(fontSize: 16),)),
                              Expanded(child: Text("A8JM5",style: TextStyle(fontSize: 16),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text("Class",style: TextStyle(fontSize: 16),)),
                              Expanded(child: Text("-",style: TextStyle(fontSize: 16),)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(child: Text("Flag",style: TextStyle(fontSize: 16),)),
                              Expanded(child: Text("Liberia",style: TextStyle(fontSize: 16),)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              )

            ],
          )
        ],
      ),
    );
  }
}

class ProductPage extends StatelessWidget {
  final Map<String, dynamic> product;

  ProductPage({this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Column(
          children: [
            Text(
              this.product['name'],
              style: Theme.of(context).textTheme.headline,
            ),
            Text(
              this.product['price'].toString() + ' USD',
              style: Theme.of(context).textTheme.subhead,
            )
          ],
        ),
      ),
    );
  }
}

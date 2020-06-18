import 'package:abbasigroup/Classes/Users.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:intl/intl.dart'; //for date format
import 'package:http/http.dart' as http;

import 'dart:convert';

class Booking extends StatefulWidget {
  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  int inc = 0;
  int incKg = 0;
  Users _currentUser;

  int value = 0;

  _addItem() {
    setState(() {
      value = value + 1;
    });
  }
  _delItem() {
    setState(() {
      value = value - 1;
    });
  }
  Future<List<Users>> _tagList;
  final String uri = 'https://jsonplaceholder.typicode.com/users';
  String radioItem = '';
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

  bool monVal = false;
  bool tuVal = false;
  bool wedVal = false;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Your Booking Details",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  activeColor: Color(0xff2a5298),
                  groupValue: radioItem,
                  title: Text('Merchant Haulage (CY)'),
                  value: 'Item 1',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  activeColor: Color(0xff2a5298),
                  groupValue: radioItem,
                  title: Text('Carrier Haulage (SD)'),
                  value: 'Item 2',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
              ),
//              Text(
//                '$radioItem',
//                style: TextStyle(fontSize: 23),
//              )
            ],
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
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
                            hint: Text('From City, Country/Region'),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: RadioListTile(
                  activeColor: Color(0xff2a5298),
                  groupValue: radioItem,
                  title: Text('Merchant Haulage (CY)'),
                  value: 'Item 1',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  activeColor: Color(0xff2a5298),
                  groupValue: radioItem,
                  title: Text('Carrier Haulage (SD)'),
                  value: 'Item 2',
                  onChanged: (val) {
                    setState(() {
                      radioItem = val;
                    });
                  },
                ),
              ),
//              Text(
//                '$radioItem',
//                style: TextStyle(fontSize: 23),
//              )
            ],
          ),
          Container(
            child: Padding(
              padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
              child: Container(
                decoration:
                    BoxDecoration(border: Border.all(color: Colors.black)),
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
                            hint: Text('To City, Country/Region'),
                          );
                        }),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 30, top: 8, bottom: 8),
            child: Container(
              decoration:
                  BoxDecoration(border: Border.all(color: Colors.black)),
              child: Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                      ),
                      child: finaldate == null
                          ? Text(
                              "Earliest Departure Date",
                              style:
                                  TextStyle(fontSize: 18, color: Colors.grey),
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
          Text("Container with your booking"),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                    hint: Text('Select Commodity'),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Color(0xff2a5298),
                          value: monVal,
                          onChanged: (bool value) {
                            setState(() {
                              monVal = value;
                            });
                          },
                        ),
                        Text("This Cargo Requires temperature control"),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Color(0xff2a5298),
                          value: monVal,
                          onChanged: (bool value) {
                            setState(() {
                              monVal = value;
                            });
                          },
                        ),
                        Text("This Cargo is considered dangerous"),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: Column(
                children: <Widget>[
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
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
                                    hint:
                                    Text('Select Container Type and Size'),
                                  );
                                }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 0),
                      child: Text("Number of Containers"),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: FlatButton.icon(
                                    onPressed: add,
                                    icon: Icon(Icons.add),
                                    label: Text(""))),
                            Expanded(
                                child: Text(
                                  "$inc",
                                  textAlign: TextAlign.center,
                                )),
                            Expanded(
                                child: FlatButton.icon(
                                    onPressed: subs,
                                    icon: Icon(Icons.remove),
                                    label: Text(""))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 0),
                      child: Text("Weight per Container (kg - cargo only)"),
                    ),
                  ),
                  Container(
                    child: Padding(
                      padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Expanded(
                                child: FlatButton.icon(
                                    onPressed: addKg,
                                    icon: Icon(Icons.add),
                                    label: Text(""))),
                            Expanded(
                                child: Text(
                                  "$incKg",
                                  textAlign: TextAlign.center,
                                )),
                            Expanded(
                                child: FlatButton.icon(
                                    onPressed: subsKg,
                                    icon: Icon(Icons.remove),
                                    label: Text(""))),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Color(0xff2a5298),
                          value: monVal,
                          onChanged: (bool value) {
                            setState(() {
                              monVal = value;
                            });
                          },
                        ),
                        Expanded(child: Text( "I wish to use Shipper's own Container an report return container or a triangulation option",softWrap: true,)),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
                    child: Row(
                      children: <Widget>[
                        Checkbox(
                          activeColor: Color(0xff2a5298),
                          value: monVal,
                          onChanged: (bool value) {
                            setState(() {
                              monVal = value;
                            });
                          },
                        ),
                        Text("the Cargo is oversized"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
              itemCount: this.value,
              itemBuilder: (context, index) => this.uiContainer(index))
          ,
          FlatButton.icon(onPressed: _addItem, icon: Icon(Icons.add), label: Text("ADD ANOTHER CONTAINER TYPE/SIZE"))
        ],

      ),
    ));
  }
  _buildRow(int index) {
    return Text("Item " + index.toString());
  }
  Widget uiContainer(int index){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(

          children: <Widget>[
            Row(
              children: <Widget>[
                FlatButton.icon(onPressed: _delItem, icon: Icon(Icons.delete,color: Color(0xff2a5298),), label: Text("Delete",style:  TextStyle(color: Color(0xff2a5298)), )),
                Text("Item " + index.toString(),style: TextStyle(color: Colors.white),)
              ],
            )
            ,
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
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
                              hint:
                              Text('Select Container Type and Size'),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 0),
                child: Text("Number of Containers"),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: FlatButton.icon(
                              onPressed: add,
                              icon: Icon(Icons.add),
                              label: Text(""))),
                      Expanded(
                          child: Text(
                            "$inc",
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          child: FlatButton.icon(
                              onPressed: subs,
                              icon: Icon(Icons.remove),
                              label: Text(""))),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 0),
                child: Text("Weight per Container (kg - cargo only)"),
              ),
            ),
            Container(
              child: Padding(
                padding: EdgeInsets.fromLTRB(30.0, 10, 30.0, 10.0),
                child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                          child: FlatButton.icon(
                              onPressed: addKg,
                              icon: Icon(Icons.add),
                              label: Text(""))),
                      Expanded(
                          child: Text(
                            "$incKg",
                            textAlign: TextAlign.center,
                          )),
                      Expanded(
                          child: FlatButton.icon(
                              onPressed: subsKg,
                              icon: Icon(Icons.remove),
                              label: Text(""))),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Color(0xff2a5298),
                    value: monVal,
                    onChanged: (bool value) {
                      setState(() {
                        monVal = value;
                      });
                    },
                  ),
                  Expanded(child: Text( "I wish to use Shipper's own Container an report return container or a triangulation option",softWrap: true,)),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(30.0, 0, 30.0, 0),
              child: Row(
                children: <Widget>[
                  Checkbox(
                    activeColor: Color(0xff2a5298),
                    value: monVal,
                    onChanged: (bool value) {
                      setState(() {
                        monVal = value;
                      });
                    },
                  ),
                  Text("the Cargo is oversized"),
                ],
              ),
            ),
          ],
        ),
      ),
    );

  }


  void add() {
    inc++;

    setState(() {
      inc;
    });
  }

  void subs() {
    if (inc == 0) {
      return;
    } else {
      inc--;
    }
    setState(() {
      inc;
    });
  }

  void addKg() {
    incKg = incKg + 100;

    setState(() {
      incKg;
    });
  }

  void subsKg() {
    if (incKg == 0) {
      return;
    } else {
      incKg = incKg - 100;
    }
    setState(() {
      incKg;
    });
  }
}

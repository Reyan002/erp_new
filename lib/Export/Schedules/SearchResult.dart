import 'package:abbasigroup/Export/Schedules/PointToPoint.dart';
import 'package:abbasigroup/Fragments/Export.dart';
import 'package:abbasigroup/models/newsArticle.dart';
import 'package:abbasigroup/services/webservice.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SearchResult extends StatefulWidget {
  const SearchResult({Key key, this.destination}) : super(key: key);

  final Destination destination;
  @override
  _SearchResultState createState() => _SearchResultState(destination);
}

class _SearchResultState extends State<SearchResult> {
  Destination destination;

  _SearchResultState(this.destination);

  List<NewsArticle> _newsArticles = List<NewsArticle>();
  void _populateNewsArticles() {
    Webservice().load(NewsArticle.all).then((newsArticles) => {
          setState(() => {_newsArticles = newsArticles})
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _populateNewsArticles();
  }

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
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: AppBar(
          title: Text(destination.title),
          backgroundColor: destination.color,
        ),
        body: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Text("3 Sailing for"),
                ],
              ),
            ),
            Container(
             width:double.infinity,
               height: 200,
               decoration:BoxDecoration(color: Colors.grey[300]),
              child: Column(

                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: <Widget>[
                      FlatButton.icon(onPressed: ( ){},materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,  icon: Icon(Icons.fiber_manual_record), label: Text("Jabel Ali - CY")),
                    ],
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 22),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,

                      children: <Widget>[
                        Container(

                          decoration: BoxDecoration(color: Colors.black),
                          width:2,
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 22),

                          child: Text("United Arab Emirates",style: TextStyle(fontSize: 12,color: Colors.grey),),
                        )
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,

                    children: <Widget>[
                      FlatButton.icon(onPressed: ( ){},materialTapTargetSize: MaterialTapTargetSize.shrinkWrap, icon: Icon(Icons.location_on), label: Text("Jabel Ali - CY")),
                    ],
                  ),
               Row(
                 mainAxisAlignment: MainAxisAlignment.start,
                 children: <Widget>[
                   Padding(
                     padding: const EdgeInsets.only(left: 45),
                     child: Text("United Arab Emirates",style: TextStyle(fontSize: 12,color: Colors.grey),),
                   ),
                 ],
               ),


                  Padding(
                    padding: const EdgeInsets.only(left: 22,top: 10),
                    child: Row(
                      children: <Widget>[

                        Expanded(
                          child: Text("Earliest Departure"),
                        ),
                        Expanded(
                          child: Text("15 Jun 2020"),
                        )
                      ],
                    ),
                  )
,
                  Padding(
                    padding: const EdgeInsets.only(left: 22,top: 5),
                    child: Row(
                      children: <Widget>[

                        Expanded(
                          child: Text("Number of Weeks"),
                        ),
                        Expanded(
                          child: Text("4"),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.only(left: 22,top: 5),
                    child: Row(
                      children: <Widget>[

                        Expanded(
                          child: Text("Container Type"),
                        ),
                        Expanded(
                          child: Text("140' Dry Standard"),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

            Expanded(
              child: _newsArticles.isEmpty
                  ? Center(child: Text('Empty'))
                  : ListView.builder(
                itemCount: _newsArticles.length,
                itemBuilder: _buildItemsForListView,
              ),
            )
          ],
        ),

    );
  }

  Widget _buildItemsForListView(BuildContext context, int index) {
    return new GestureDetector(

      onTap: () {
        Navigator.pushNamed(context, "/det");
      },
      child: new Card(

        child: Row(
          children: <Widget>[
            Expanded(
              child: ExpandableNotifier(
                  child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                child: ScrollOnExpand(
                  child: Card(
                    clipBehavior: Clip.antiAlias,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
//                           Expandable(
//                             collapsed: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         FlatButton.icon(
//                                             onPressed: () {},
//                                             icon: Icon(Icons.directions_boat),
//                                             label: Text(
//                                               _newsArticles[index].author,
//                                               softWrap: true,
//                                             ))
//                                       ],
//                                     ),
//                                   ),
//                                 ]),
//                             expanded: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: <Widget>[
//                                   Padding(
//                                     padding: EdgeInsets.all(10),
//                                     child: Column(
//                                       crossAxisAlignment: CrossAxisAlignment.start,
//                                       children: <Widget>[
//                                         FlatButton.icon(
//                                             onPressed: () {},
//                                             icon: Icon(Icons.directions_boat),
//                                             label:
//                                             Text(_newsArticles[index].title)),
//                                         FlatButton.icon(
//                                             onPressed: () {},
//                                             icon: Icon(Icons.access_time),
//                                             label: Text("Deadlines")),
//                                       ],
//                                     ),
//                                   ),
//                                 ]),
//                           ),
                        Expandable(
                          collapsed: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: FlatButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.location_on),
                                              label: Text("Departure")),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("05 Jun 2020"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                              "South Asia Pakistan Terminal"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: FlatButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.location_on),
                                              label: Text("Arrival")),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("05 Jun 2020"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("PSA Singapore Terminal"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: FlatButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.directions_boat),
                                              label: Flexible(
                                                child: Container(
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(8.0),
                                                      child: Text(
                                                  _newsArticles[index].title,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                    )),
                                              )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("COSCO JAPAN"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("083E"),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: FlatButton.icon(
                                              onPressed: () {},
                                              icon: Icon(Icons.access_time),
                                              label: Text("Transit Time")),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("10 Days"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("  "),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                          expanded: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("CY:"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "01 Jun 2020 15:00",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("SI - NON AMS:"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "01 Jun 2020 15:00",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                children: <Widget>[
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("SI - AMS:"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "01 Jun 2020 15:00",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text("VGM:"),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            "01 Jun 2020 15:00",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Expandable(
                            collapsed: Container(),
                            expanded: Container(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  ListView.builder(
                                    physics: ClampingScrollPhysics(),
                                    shrinkWrap: true,
                                    itemCount: names.length,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      return Column(
                                        children: <Widget>[
                                          Text("${names[index]}")
                                        ],
                                      );
                                    },
                                  )
                                ],
                              ),
                            )),
//                        Divider(
//                          height: 1,
//                        ),
//                        Row(
//                          mainAxisAlignment: MainAxisAlignment.start,
//                          children: <Widget>[
//                            Builder(
//                              builder: (context) {
//                                var controller = ExpandableController.of(context);
//                                return FlatButton(
//                                  child: Text(
//                                    controller.expanded ? "COLLAPSE" : "EXPAND",
//                                    style: Theme.of(context)
//                                        .textTheme
//                                        .button
//                                        .copyWith(color: Color(0xff2a5298)),
//                                  ),
//                                  onPressed: () {
//                                    controller.toggle();
//                                  },
//                                );
//                              },
//                            ),
//                          ],
//                        ),
                      ],
                    ),
                  ),
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

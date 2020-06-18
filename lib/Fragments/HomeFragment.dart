import 'package:abbasigroup/Fragments/Export.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ListItems> postList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postList.add(new ListItems("Account", "assets/images/budget.png",0xffb92b27));
    postList.add(new ListItems("Export", "assets/images/share.png",0xfff12711));
    postList.add(new ListItems("Import", "assets/images/importa.png",0xffCAC531));
    postList
        .add(new ListItems("CFA", "assets/images/work.png",0xff11998e));
    postList.add(new ListItems("Trading", "assets/images/stable.png",0xff2193b0));
    postList.add(new ListItems("HRMS", "assets/images/project.png",0xff4286f4));
    postList.add(new ListItems("Live Chat", "assets/images/live.png",0xff1f4037));
    postList.add(new ListItems("Dashboard", "assets/images/dashboard.png",0xff2C5364));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Container(
        child: postList.length == 0
            ? new Text("No Item Is Available")
            : new GridView.builder(

                itemCount: postList.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (_, index) {

                  return GestureDetector(
                    child: myCircularItems(
                        postList[index].title, postList[index].image,postList[index].color),
                  onTap: ()  {
                      if(index==1){
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Export()),
                        );
                      }
                  }
                  );

                }),
      ),
    );
  }

  Widget myCircularItems(String title, String image,int color) {
    return Container(
      padding: EdgeInsets.all(8),
      child: Material(
        color: Color(color),
        elevation: 14.0,
        borderRadius: BorderRadius.circular(24.0),
        shadowColor: Color(0x802196F3),
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        title,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: 100,
                        width: 100,
                        child: new Image.asset(
                          image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ListItems {
  String title;
  String image;
  int color;

  ListItems(this.title, this.image,this.color);
}

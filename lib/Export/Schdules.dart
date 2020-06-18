import 'package:abbasigroup/Export/Schedules/PointToPoint.dart';
import 'package:abbasigroup/Export/Schedules/PortCalls.dart';
import 'package:abbasigroup/Export/Schedules/SearchResult.dart';
import 'package:abbasigroup/Export/Schedules/VesselSchedule.dart';
import 'package:abbasigroup/Fragments/Export.dart';
import 'package:flutter/material.dart';
class Schedules extends StatefulWidget {
  const Schedules({ Key key, this.destination }) : super(key: key);

  final Destination destination;
  @override
  _SchedulesState createState() => _SchedulesState(destination);
}

class _SchedulesState extends State<Schedules> with SingleTickerProviderStateMixin{
  TabController _tabController;

  _SchedulesState(this.destination);

  Destination destination;

  @override
  void initState() {
    _tabController = new TabController(length: 3, vsync: this);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar:   AppBar(
        title: Text(destination.title),
        backgroundColor: destination.color,
        bottom: TabBar(
            unselectedLabelColor: Colors.grey,
            labelColor: Colors.white,
            tabs: [
              new Tab( text: "Point-to-Point",),
              new Tab(
                text: "Port Calls",
              ),
              new Tab(
                text: "Vessel Schedules",
              )
            ],
            controller: _tabController,
            indicatorColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,),
      ),


      body: TabBarView(
        children: [
            PointToPoint(),
            PortCalls(),
            VesselSchedule(),

        ],
        controller: _tabController,),
    );
  }
}

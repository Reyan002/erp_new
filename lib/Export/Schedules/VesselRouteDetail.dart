import 'package:abbasigroup/Fragments/Export.dart';
import 'package:flutter/material.dart';
class VesselRouteDetail extends StatefulWidget {
  const VesselRouteDetail({Key key, this.destination}) : super(key: key);

  final Destination destination;
  @override
  _VesselRouteDetailState createState() => _VesselRouteDetailState(destination);
}

class _VesselRouteDetailState extends State<VesselRouteDetail> {
  Destination destination;

  _VesselRouteDetailState(this.destination);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        title: Text(destination.title),
        backgroundColor: destination.color,
      ),
    );
  }
}

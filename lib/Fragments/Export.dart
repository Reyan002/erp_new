import 'package:abbasigroup/Classes/DrawerItems.dart';
import 'package:abbasigroup/Export/Booking.dart';
import 'package:abbasigroup/Export/ExportPage.dart';
import 'package:abbasigroup/Export/QuoteReq.dart';
import 'package:abbasigroup/Export/Schdules.dart';
import 'package:abbasigroup/Export/Schedules/PointToPoint.dart';
import 'package:abbasigroup/Export/Schedules/PortCalls.dart';
import 'package:abbasigroup/Export/Schedules/SearchResult.dart';
import 'package:abbasigroup/Export/Schedules/VesselRouteDetail.dart';
import 'package:abbasigroup/Export/Schedules/VesselSchedule.dart';
import 'package:abbasigroup/Export/Tarrif.dart';
import 'package:abbasigroup/Screens/Home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';


class Export extends StatefulWidget {
  final drawerItems = [
    new DrawerItem("Export", Icons.exit_to_app),
    new DrawerItem("Schedule", Icons.schedule),
    new DrawerItem("Booking", Icons.book),
    new DrawerItem("Quote Request", Icons.format_quote),
    new DrawerItem("Tariff", Icons.text_fields),

  ];



  @override
  _ExportState createState() => _ExportState( );



 }
class Helper {
  static printing(String someText){
    print(someText);
  }
}

class _ExportState extends State<Export> with TickerProviderStateMixin<Export> {
  List<Key> _destinationKeys;
  List<AnimationController> _faders;
  AnimationController _hide;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();

    _faders = allDestinations.map<AnimationController>((Destination destination) {
      return AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    }).toList();
    _faders[_currentIndex].value = 1.0;
    _destinationKeys = List<Key>.generate(allDestinations.length, (int index) => GlobalKey()).toList();
    _hide = AnimationController(vsync: this, duration: kThemeAnimationDuration);
  }

  @override
  void dispose() {
    for (AnimationController controller in _faders)
      controller.dispose();
    _hide.dispose();
    super.dispose();
  }

  bool _handleScrollNotification(ScrollNotification notification) {
    if (notification.depth == 0) {
      if (notification is UserScrollNotification) {
        final UserScrollNotification userScroll = notification;
        switch (userScroll.direction) {
          case ScrollDirection.forward:
            _hide.forward();
            break;
          case ScrollDirection.reverse:
            _hide.reverse();
            break;
          case ScrollDirection.idle:
            break;
        }
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: _handleScrollNotification,
      child: Scaffold(
        body: SafeArea(
          top: false,
          child: Stack(
            fit: StackFit.expand,
            children: allDestinations.map((Destination destination) {
              final Widget view = FadeTransition(
                opacity: _faders[destination.index].drive(CurveTween(curve: Curves.fastOutSlowIn)),
                child: KeyedSubtree(
                  key: _destinationKeys[destination.index],
                  child: DestinationView(
                    destination: destination,
                    onNavigation: () {
                      _hide.forward();
                    },
                  ),
                ),
              );
              if (destination.index == _currentIndex) {
                _faders[destination.index].forward();
                return view;
              } else {
                _faders[destination.index].reverse();
                if (_faders[destination.index].isAnimating) {
                  return IgnorePointer(child: view);
                }
                return Offstage(child: view);
              }
            }).toList(),
          ),
        ),
        bottomNavigationBar: ClipRect(
          child: SizeTransition(
            sizeFactor: _hide,
            axisAlignment: -1.0,
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              onTap: (int index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: allDestinations.map((Destination destination) {
                return BottomNavigationBarItem(
                    icon: Icon(destination.icon),
                    backgroundColor: destination.color,
                    title: Text(destination.title)
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
class Destination {
  const Destination(this.index, this.title, this.icon, this.color);
  final int index;
  final String title;
  final IconData icon;
  final MaterialColor color;
}

const List<Destination> allDestinations = <Destination>[
  Destination(0, 'Export', Icons.import_export, Colors.teal),
  Destination(1, 'Schedule', Icons.schedule, Colors.cyan),
  Destination(2, 'Booking', Icons.book, Colors.blueGrey),
  Destination(3, 'Tariff', Icons.text_fields, Colors.blue)
];
class DestinationView extends StatefulWidget {
  const DestinationView({ Key key, this.destination, this.onNavigation }) : super(key: key);

  final Destination destination;
  final VoidCallback onNavigation;

  @override
  _DestinationViewState createState() => _DestinationViewState();
}

class _DestinationViewState extends State<DestinationView> {
  @override
  Widget build(BuildContext context) {
    return Navigator(
      observers: <NavigatorObserver>[
        ViewNavigatorObserver(widget.onNavigation),
      ],
      onGenerateRoute: (RouteSettings settings) {
        return MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            switch(settings.name) {
              case '/':
                return Schedules(destination: widget.destination);
              case '/list':
                return SearchResult(destination: widget.destination);
              case '/det':
                return VesselRouteDetail(destination: widget.destination);

            }
          },
        );
      },
    );
  }
}


class ViewNavigatorObserver extends NavigatorObserver {
  ViewNavigatorObserver(this.onNavigation);

  final VoidCallback onNavigation;

  void didPop(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    onNavigation();
  }
}
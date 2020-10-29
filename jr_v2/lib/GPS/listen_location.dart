import 'dart:async';

import 'package:flutter/material.dart';
import 'package:jr_v1/home.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';

//static으로 만들고 싶은데 어떻게 해야할지 모르겟음
bool isGps= false;
LocationData publicLocationData;
String locationErr;
Stream ld;

class ListenLocationWidget extends StatefulWidget {
  const ListenLocationWidget({Key key}) : super(key: key);

  @override
  _ListenLocationState createState() => _ListenLocationState();
}

class _ListenLocationState extends State<ListenLocationWidget> {
  final Location location = Location();

  LocationData _locationData;
  StreamSubscription<LocationData> _locationSubscription;
  String _error;

  Future<void> _listenLocation() async {
    setState(() {

      _locationSubscription =
          location.onLocationChanged.handleError((dynamic err) {
            setState(() {
              _error = err.code;
              locationErr = err.code;
            });
            _locationSubscription.cancel();
          }).listen((LocationData currentLocation) {
            setState(() {
              _error = null;

              _locationData = currentLocation;
              publicLocationData = currentLocation;
            });
          });
      print('위치는$_locationSubscription');

    });

  }


  Future<void> _stopListen() async {
    _locationSubscription.cancel();
  }

//  WebViewController webViewController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[

        StreamBuilder(
          stream: Stream.periodic(Duration(seconds: 1)),
          builder: (context, snapshot)=>IconButton(
            icon: (isGps ? Icon(Icons.gps_fixed,) : Icon(Icons.gps_not_fixed)),
            color: Colors.white,
            iconSize: 30,
            onPressed: (){
              isGps ? isGps = false: isGps = true;
              setState(() {
                gPSToggleStatus();
                print(publicLocationData);
                //추가
                if(isGps){
                    var lat =publicLocationData.latitude;
                    var lng = publicLocationData.longitude;
                    webViewController.evaluateJavascript("GetPos($lat,$lng);")?.then((result){
                      print('JS로부터온 $result 메시지');
                      print('$lat,$lng');
                    });


//                    JavascriptChannel(
//                      name: 'jam',
//                      //Js to flutter메시지 받기
//                      onMessageReceived: (JavascriptMessage result) {
//                        print('메시지: ${result.message}');
//                      },
//                    );
                }
                  //여기까지
              });
            },
          ),
        ),
      ],
    );
  }

  void gPSToggleStatus() {

    setState(() {
      if(isGps){
        _listenLocation();
      }
      else{
        _stopListen();
      }
      print(isGps);

    });
  }
}




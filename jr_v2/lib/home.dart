import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:jr_v1/GPS/listen_location.dart';
import 'package:jr_v1/Util/stopwatch.dart';
import 'package:jr_v1/menu.dart';
import 'package:location/location.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: HomeApp(),
    );
  }
}

class HomeApp extends StatefulWidget {
  @override
  _HomeAppState createState() => _HomeAppState();
}

WebViewController webViewController;
LatLng _initialcameraposition = LatLng(37.264842, 126.96033);

class _HomeAppState extends State<HomeApp> {
  List<LatLng> _points = List<LatLng>();
  Set<Polyline> _polylines = Set<Polyline>();
  Location _location = Location();
  StreamSubscription<LocationData> _locationSubscription;
  Future<LocationData> _locationData;
  GoogleMapController _controller;
  StopWatchUtil _stopWatchUtil = StopWatchUtil();


  Future<void> _onMapCreated(GoogleMapController _cntlr) async {
    _controller = _cntlr;
    _locationSubscription = _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 19),
        ),
      );
      _points.add(LatLng(l.latitude, l.longitude));
      setState(() {
        _polylines.add(Polyline(
          polylineId: PolylineId('0'),
          points: _points,
          color: Colors.red,
//            width: 10
        ));
      });
      _stopListen(_controller);
//      ShowCurrentPos(_locationData);
    });
  }

  Future<void> _startListen(GoogleMapController _cntlr) async {
    int i = 0;
    _controller = _cntlr;
    if (isGps == true) {
      _locationSubscription = _location.onLocationChanged.listen((l) {
        _controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: LatLng(l.latitude, l.longitude), zoom: 19),
          ),
        );

        _points.add(LatLng(l.latitude, l.longitude));
        _polylines.add(Polyline(
          polylineId: PolylineId('0'),
          points: _points,
          color: Colors.red,
//            width: 10
        ));
      });
    }
  }

  // locationData 끊기 (gps추적 x)
  Future<void> _stopListen(GoogleMapController _cntrl) async {
    _locationSubscription.cancel();
    _controller = _cntrl;

    _locationData = _location.getLocation();
    double latitude;
    double longitude;
    await _locationData.then((value) {
      latitude = value.latitude;
      longitude = value.longitude;
    });
    print('here, $latitude, $longitude');
    LatLng latLng = LatLng(latitude, longitude);
    ShowCurrentPos(latLng);

//    _points.clear();
  }

  bool Trackable() {
    setState(() {
      if (isGps == true) {
        isGps = false;
        _stopListen(_controller);
        _stopWatchUtil.startStopWatch();
      } else {
        isGps = true;
//        _onMapCreated(_controller);
        _startListen(_controller);
        _stopWatchUtil.stopStopWatch();
        //todo
      }
    });
  }

  void ShowCurrentPos(LatLng latlng) {
    print('imhere, $latlng');
//    LatLng latlng = LatLng(newLocationData.latitude, newLocationData.longitude);
    setState(() {
      ///todo stop listen시 내 위치를 보여주는 기능 추가 아마도 마커[0]을
      ///내위치 보여주는걸로 쓰면 될거 같음
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.blue),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: <Widget>[
        GoogleMap(
          //todo 카메라 첫위치
          initialCameraPosition: CameraPosition(target: _initialcameraposition, zoom: 14),
          mapType: MapType.normal,
          //todo init위치를 모바일에 있는 로케이션 불러오게 하기
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: false,
          myLocationEnabled: isGps,
          polylines: _polylines,
        ),
        Text(_stopWatchUtil.stoptimetodisplay),
        Positioned(
          //todo 각각의 UI에 맞게 화면을 맞출 수 있도록 정수에서 반응형으로 변경시키기
          left: 5,
          bottom: 15,
          child: Container(
            alignment: Alignment.center,
            child: Column(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: ButtonTheme(
                    minWidth: 400,
                    height: 200,
                    buttonColor: Colors.yellow[700],
                    child: RaisedButton(
                      onPressed: () {
                        Trackable();
                      },
                      child: Text(
                        'Run',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 130,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
      drawer: Drawer(
        child: MenuList(),
      ),
    );
  }
}

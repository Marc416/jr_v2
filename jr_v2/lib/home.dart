import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:jr_v1/GPS/listen_location.dart';
import 'package:jr_v1/menu.dart';
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
class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow[700],
        title: Text(
          'JooRun',
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
        elevation: 0.0,
        actions: <Widget>[
          ListenLocationWidget(),
        ],
      ),
      body: SafeArea(
        child: Stack(children: <Widget>[
          Scaffold(
            body: StreamBuilder(
              stream: Stream.periodic(Duration(seconds: 1)),
              builder: (context, snapshot) {

              if(isGps){
                var lat =publicLocationData.latitude;
                var lng = publicLocationData.longitude;
              webViewController.evaluateJavascript("GetPos($lat,$lng);")?.then((result){
              print('JS로부터온 $result 메시지');
              print('$lat,$lng');
                });}
               return WebView(
                initialUrl: 'http://34.68.194.62/',
                onPageFinished: (String url) {
                  print('웹뷰' + url);
                },
                javascriptMode: JavascriptMode.unrestricted,
                javascriptChannels: Set.from([
                  JavascriptChannel(
                    name: 'jam',
                    //Js to flutter메시지 받기
                    onMessageReceived: (JavascriptMessage result) {
                      print('메시지: ${result.message}');
                    },
                  ),
                ]),
                onWebViewCreated: (controller) {
                  webViewController = controller;
                },
              );},
            ),
          ),
          Positioned(
            //젠장 가운데로 맞춰줘야하는데... 젠장 이걸로 맞추는게 아닌데
            left: 5,
            bottom: 15,
            child: Container(
              alignment: Alignment.center,
              child: Column(
                children: <Widget>[
                  StreamBuilder(
                    stream: Stream.periodic(
                      Duration(seconds: 1),
                    ),
                    builder: (context, snapshot) =>
                        Text(publicLocationData.toString()),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: ButtonTheme(
                      minWidth: 400,
                      height: 200,
                      buttonColor: Colors.yellow[700],
                      child: RaisedButton(
                        onPressed: () {},
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
      ),
//    ),
//    ),
//          floatingActionButtonLocation:
//              FloatingActionButtonLocation.centerDocked,
//          floatingActionButton: Container(
//            child: Column(
//              children: <Widget>[
//                StreamBuilder(
//                  stream: Stream.periodic(
//                    Duration(seconds: 1),
//                  ),
//                  builder: (context, snapshot) =>
//                      Text(publicLocationData.toString()),
//                ),
//                Align(
//                  alignment: Alignment.bottomCenter,
//                  child: ButtonTheme(
//                    minWidth: 400,
//                    height: 200,
//                    buttonColor: Colors.yellow[700],
//                    child: RaisedButton(
//                      onPressed: () {},
//                      child: Text(
//                        'Run',
//                        style: TextStyle(
//                          color: Colors.black,
//                          fontSize: 130,
//                        ),
//                      ),
//                    ),
//                  ),
//                ),
//              ],
//            ),
//          ),

//      Center(
//        child: ButtonTheme(
//          minWidth: 400,
//          height: 200,
//          child: Container(
//            margin: EdgeInsets.only(bottom: 10), //바닥으로부터의 여백
//            child: Align(
//              alignment: Alignment.bottomCenter,
//              child: Column(children: <Widget>[
//                StreamBuilder(
//                  stream: Stream.periodic(Duration(seconds: 1),
//                  ),
//                  builder: (context, snapshot) =>Text(publicLocationData.toString()),
//                ),
//                RaisedButton(
//                  child: Text(
//                    'Run',
//                    style: TextStyle(
//                      color: Colors.black,
//                      fontSize: 130,
//                    ),
//                  ),
//                  onPressed: () {
//                    //버튼 눌렀을 때 실행될 함수
//                  },
//                  color: Colors.yellow[700],
//                ),
//              ]),
//            ),
//          ),
//        ),
//      ),
      drawer: Drawer(
        child: MenuList(),
      ),
    );
  }
}

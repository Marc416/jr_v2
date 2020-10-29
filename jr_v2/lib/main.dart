import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:jr_v1/GPS/permission_status.dart';
import 'package:jr_v1/home.dart';

import 'Menu/recordbody.dart';
import 'menu.dart';

void main() {

  runApp(RunApp());
}

class RunApp extends StatefulWidget {
  @override
  _RunAppState createState() => _RunAppState();
}

class _RunAppState extends State<RunApp> {
  SetGpsPermission setGpsPermission = new SetGpsPermission();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/home',
      routes: {
        '/home':(context) => Home(),
        '/menu':(context) => MenuList(),
        '/record':(context) => Record(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}


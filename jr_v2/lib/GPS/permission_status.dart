import 'package:flutter/material.dart';
import 'package:location/location.dart';

class SetGpsPermission {

  SetGpsPermission(){
    gpsPermission();
  }

  final Location location = Location();
  PermissionStatus _permissionGranted;

  void gpsPermission() {
    if(_permissionGranted == PermissionStatus.granted){
      print('GPS권한이 있음');
      return;
    }
    _checkPermissions();
    _requestPermission();
    print('메시지$_permissionGranted');
  }

  Future<void> _requestPermission() async {
    //권한이 없다면
    if (_permissionGranted != PermissionStatus.granted) {
      final PermissionStatus permissionRequestedResult =
          await location.requestPermission();
      _permissionGranted = permissionRequestedResult;
      if (permissionRequestedResult != PermissionStatus.granted) {
        return;
      }
    }
  }

  Future<void> _checkPermissions() async {
    final PermissionStatus permissionGrantedResult =
    await location.hasPermission();
      _permissionGranted = permissionGrantedResult;
  }
}

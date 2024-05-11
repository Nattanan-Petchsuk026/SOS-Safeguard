import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late Position _currentPosition ;
  String _address = '';

  @override
  void initState() {
    super.initState();
    _checkPermission();
  }

  void _checkPermission() async {
    PermissionStatus permission = await Permission.locationWhenInUse.status;
    if (permission != PermissionStatus.granted) {
      permission = await Permission.locationWhenInUse.request();
      if (permission != PermissionStatus.granted) {
        // Handle denied permission
        return;
      }
    }
    _getCurrentLocation();
  }

 void _getCurrentLocation() async {
  try {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      _currentPosition = position;
      _getAddress(); // เรียกใช้งาน _getAddress() ทันทีหลังจากกำหนดค่า _currentPosition
    });
  } catch (e) {
    print(e.toString());
    // Handle error here
  }
}






  void _getAddress() async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
          _currentPosition.latitude, _currentPosition.longitude);
      Placemark placemark = placemarks.last;

      setState(() {
        _address = '${placemark.thoroughfare}, ${placemark.subThoroughfare}, ${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.postalCode}, ${placemark.country}';
      });
    } catch (e) {
      print(e.toString());
      // Handle error here
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Example'),
      ),
      body: Center(
        child: _currentPosition != null
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Lat: ${_currentPosition.latitude}, Long: ${_currentPosition.longitude}',
                  ),
                  Text(
                    _address,
                  ),
                ],
              )
            : CircularProgressIndicator(),
      ),
    );
  }
}
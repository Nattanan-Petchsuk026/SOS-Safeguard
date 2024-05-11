import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

class SafeHome extends StatefulWidget {
  @override
  State<SafeHome> createState() => _SafeHomeState();
}

class _SafeHomeState extends State<SafeHome> {
  Position? currentPosition;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<String> _getAddressFromCoordinates(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        return placemark.locality ?? 'Unknown Location';
      } else {
        return 'Unknown Location';
      }
    } catch (e) {
      print("Error getting address: $e");
      return 'Unknown Location';
    }
  }

  Future<void> _getCurrentLocation() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      try {
        Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high,
        );
        setState(() {
          currentPosition = position;
        });
      } catch (e) {
        print("Error: $e");
      }
    } else {
      print("Location permission is not granted");
    }
  }

  Future<void> _launchGoogleMaps() async {
    if (currentPosition != null) {
      print('Launching Google Maps with position: $currentPosition');
      double latitude = currentPosition!.latitude;
      double longitude = currentPosition!.longitude;
      String googleMapsUrl =
          'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';

      if (await canLaunch(googleMapsUrl)) {
        await launch(googleMapsUrl);
      } else {
        print('Could not launch Google Maps with URL: $googleMapsUrl');
      }
    } else {
      print('Current position is null');
    }
  }

  Future<String> _getAddressDetails(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude,
        position.longitude,
      );

      if (placemarks.isNotEmpty) {
        Placemark placemark = placemarks.first;
        String street = placemark.street ?? '';
        String subLocality = placemark.subLocality ?? '';
        String locality = placemark.locality ?? '';
        String administrativeArea = placemark.administrativeArea ?? '';
        String country = placemark.country ?? '';

        List<String> addressDetails = [];
        if (street.isNotEmpty) addressDetails.add(street);
        if (subLocality.isNotEmpty) addressDetails.add(subLocality);
        if (locality.isNotEmpty) addressDetails.add(locality);
        if (administrativeArea.isNotEmpty)
          addressDetails.add(administrativeArea);
        if (country.isNotEmpty) addressDetails.add(country);

        String address = addressDetails.join(', ');

        return address.isNotEmpty ? address : 'Unknown Address';
      } else {
        return 'Unknown Address';
      }
    } catch (e) {
      print("Error getting address details: $e");
      return 'Unknown Address';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
                Color(0xFFFAFAFA),
                Color(0xFFFAFAFA),
                Color(0xFFFAFAFA),
              ],
              /*colors: [
                Color(0xFFD1C4E9),
                Color(0xFFF8BBD0),// Color(0xFFD3D3D3)
                Color(0xFFBBDEFB),
              ], */
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: InkWell(
        onTap: () {
          if (currentPosition != null) {
            _launchGoogleMaps();
          }
        },
        borderRadius: BorderRadius.circular(20),
        child: Padding(
  padding: EdgeInsets.all(25),
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "ตำแหน่งของคุณ",
        style: GoogleFonts.kanit(
          fontWeight: FontWeight.bold,
          fontSize: 16,
        ),
      ),
      SizedBox(height: 8),
      if (currentPosition != null) ...[
        FutureBuilder<String>(
          future: _getAddressDetails(currentPosition!),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.black54,
                ),
              );
            } else if (snapshot.hasError) {
              return Text(
                'Error loading address details',
                style: TextStyle(
                  color: Colors.red,
                ),
              );
            } else {
              return Text(
                snapshot.data ?? 'Unknown Address',
                style: TextStyle(
                  color: Colors.black87,
                ),
              );
            }
          },
        ),
        SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            if (currentPosition != null)
              TextButton.icon(
                onPressed: () {
                  if (currentPosition != null) {
                    double latitude = currentPosition!.latitude;
                    double longitude = currentPosition!.longitude;
                    String directionsUrl =
                        'https://www.google.com/maps/dir/?api=1&destination=$latitude,$longitude';

                    launch(directionsUrl);
                  }
                },
                icon: Icon(Icons.directions, color: Colors.black54),
                label: Text(
                  'Directions',
                  style: TextStyle(
                    color: Colors.black38,
                  ),
                ),
              ),
            TextButton.icon(
              onPressed: () {
                if (currentPosition != null) {
                  _launchGoogleMaps();
                }
              },
              icon: Icon(
                Icons.map,
                color: Colors.black54,
              ),
              label: Text(
                'View Map',
                style: TextStyle(
                  color: Colors.black38,
                ),
              ),
            ),
          ],
        ),
      ] else ...[
        SizedBox(
          width: 500,
          height: 75,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircularProgressIndicator(),
              SizedBox(height: 8),
              Text(
                'กำลังดึงข้อมูลตำแหน่ง...',
                style: TextStyle(
                  color: Colors.black54,
                ),
              ),
            ],
          ),
        ),
      ],
    ],
  ),
)));
  }
}
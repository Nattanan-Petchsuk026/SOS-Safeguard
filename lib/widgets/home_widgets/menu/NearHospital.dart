import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class NearHospital extends StatefulWidget {
  const NearHospital({Key? key, required void Function(String location) onMapFunction}) : super(key: key);

  @override
  State<NearHospital> createState() => _NearHospitalState();
}

class _NearHospitalState extends State<NearHospital> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () {
          openGoogleMaps('โรงพยาบาลใกล้ฉัน');
        },
        child: Container(
          height: MediaQuery.of(context).size.width * 0.4,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFAFAFA),
                Color(0xFFFAFAFA),
                Color(0xFFFAFAFA),
              ],
              /*
              colors: [
                Color(0xFFFFFFFF),
                Color(0xFFD3D3D3),
                Color(0xFFFFFFFF),
              ],
              */ 
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: MediaQuery.of(context).size.width * 0.08,
                    backgroundColor: Colors.white.withOpacity(0.01),
                    child: Image.asset('assets/cardiogram.png',
                        height: MediaQuery.of(context).size.width * 0.16),
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'โรงพยาบาลใกล้ฉัน',
                      style: GoogleFonts.kanit(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      'Hospital Near me',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: MediaQuery.of(context).size.width * 0.030,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void openGoogleMaps(String location) async {
    String googleUrl = 'https://www.google.com/maps/search/$location';
    final Uri _url = Uri.parse(googleUrl);
    try {
      await launch(_url.toString());
    } catch (e) {
      Fluttertoast.showToast(
          msg: 'Something went wrong! Please call the emergency number.');
    }
  }
} 
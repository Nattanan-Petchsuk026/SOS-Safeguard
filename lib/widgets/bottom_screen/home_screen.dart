import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sosapp/widgets/bottom_screen/contacts_screen.dart';
import 'package:sosapp/widgets/home_widgets/Location/location.dart';
import 'package:sosapp/widgets/home_widgets/menu/EmergencyNumber.dart';
import 'package:sosapp/widgets/home_widgets/menu/NearHospital.dart';
import 'package:sosapp/widgets/home_widgets/menu/NearPharmacy.dart';
import 'package:sosapp/widgets/home_widgets/menu/NearPolice.dart';


class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int qIndex = 0;

 

  getRandomQuote() {
    setState(() {
      qIndex = Random().nextInt(6);
    });
  }

  @override
  void initState() {
    getRandomQuote();
    super.initState();
  }

  void onMapFunction(String location) {
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: Size.fromHeight(80.0),
      child: AppBar(
        centerTitle: true,
        elevation: 1,
        automaticallyImplyLeading: false,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF0083B0),Color(0xff6849ef)],
              //colors: [Color(0xFF00B4DB), Color(0xFF0083B0)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        title: Text(
          'เมนู',
          style: GoogleFonts.kanit(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
    ),
    body: SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20),
            Text(
              "เมนูหลัก",
              style: GoogleFonts.kanit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactsPage()),
                );
              },
              child: Row(
                children: [
                  Expanded(
                    child: EmergencyNumber(),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: NearHospital(
                      onMapFunction: onMapFunction,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: NearPolice(
                    onMapFunction: (String location) {},
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: NearPharmacy(
                    onMapFunction: (String location) {},
                  ),
                ),
              ],
            ),
            SizedBox(height: 30),
            Text(
              "ตำแหน่งปัจจุบัน",
              style: GoogleFonts.kanit(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 15),
            SafeHome(),
            SizedBox(height: 75), 
          ],
        ),
      ),
    ),
  );
}
}
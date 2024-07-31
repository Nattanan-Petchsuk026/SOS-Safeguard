import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class Heroin extends StatelessWidget {
  _callNumber(String number) async {
    await FlutterPhoneDirectCaller.callNumber(number);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, bottom: 5),
      child: buildEmergencyCard(context),
    );
  }

  Widget buildEmergencyCard(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
        onTap: () => _callNumber('1138'),
        child: Container(
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
            ),
          ),
          padding: EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage(
                    'assets/drug-abuse.png'),
              ),
              SizedBox(width: 20),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ศูนย์รับแจ้งข่าวปราบปรามยาเสพติด',
                     style: GoogleFonts.kanit(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'แจ้งเบาะแสยาเวพติด',
                      style: GoogleFonts.kanit(
                        //fontWeight: FontWeight.bold,
                        fontSize: 14.0,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'สายด่วนฉุกเฉิน: 1138',
                      style: GoogleFonts.kanit(
                        color: Colors.redAccent,
                        fontSize: 14.0,
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  MdiIcons.phone,
                  color: Colors.black,
                  size: 30.0,
                ),
                onPressed: () => _callNumber('1138'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

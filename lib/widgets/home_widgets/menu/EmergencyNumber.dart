import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmergencyNumber extends StatefulWidget {
  const EmergencyNumber({Key? key}) : super(key: key);

  @override
  State<EmergencyNumber> createState() => EmergencyNumberState();
}

class EmergencyNumberState extends State<EmergencyNumber> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: InkWell(
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
                    child: Image.asset('assets/emergency-call.png', height: MediaQuery.of(context).size.width * 0.16),
                  ),
                ),
                SizedBox(height: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      'หมายเลขสายด่วน',
                      style: GoogleFonts.kanit(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.width * 0.04,
                      ),
                    ),
                    Text(
                      'Emergency Number',
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
}

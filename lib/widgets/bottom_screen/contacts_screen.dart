import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/%E0%B9%87Heroin.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/AmbulanceEmergency.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/AntiTrafficking.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/BkkBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/ConsumerProtectionBoard.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/ExpresswayAuthority.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/FirebrigadeEmergency.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/GovernmentsSavingsBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/HighwayPatrol.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/HumanSecurity.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/ICBCbank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/Insurance.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/IslamicBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/KrungThaiBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/LandTransport.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/LostCar.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/MEA.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/MWA.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/MedicalBkk.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/MentalHealth.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/PWA.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/PoliceGeneral.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/PoliceKp.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/Policeemergency.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/Pp.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/ProvincialElectricityAuthority.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/RoralRoads.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/SNS.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/StateRailway.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/Thai.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/TourismAuthority.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/TouristPoliceBureau.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/VajiraHospital.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/WaterEmergency.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/citiBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/Kplus.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/krungkriBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/scbBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/tiscoBank.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/tndwc.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/ttbBank.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({Key? key});

  @override
  _ContactsPageState createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  List<String> emergencyCategories = [
    "การแพทย์และโรงพยาบาล",
    "แจ้งเหตุด่วนเหตุร้าย",
    "การท่องเที่ยว",
    "หน่วยงานและองค์กรทั่วไป",
    "Call Center ธนาคาร",
    /*"อื่นๆ",*/
  ];

  Map<String, List<Widget>> categoryContacts = {
    "การแพทย์และโรงพยาบาล": [
      AmbulanceEmergency(),
      VajiraHospital(),
      MedicalBkk(),
      PoliceGeneral(),
      Pp(),
      MentalHealth()
      ],
    "แจ้งเหตุด่วนเหตุร้าย": [
      PoliceEmergency(),
      FirebrigadeEmergency(),
      HumanSecurity(),
      LostCar(),
      WaterEmergency(),
      tndwc(),
      PoliceKp(),
      Thai(),
      AntiTrafficking()
      ],
    "การท่องเที่ยว": [
      HighwayPatrol(),
      ExpresswayAuthority(),
      TouristPoliceBureau(),
      TourismAuthority(),
      LandTransport(),
      StateRailway(),
      RoralRoads(),
      ],
      "หน่วยงานและองค์กรทั่วไป" : [
      ConsumerProtectionBoard(),
      ProvincialElectricityAuthority(),
      MEA(),
      MWA(),
      PWA(),
      SNS(),
      Insurance(),
      Heroin(),
      ],
    "Call Center ธนาคาร" : [
      BkkBank(),
      GovernmentsSavingsBank(),
      IslamicBank(),
      TtbBank(),
      krungkriBank(),
      CitiBank(),
      ScbBank(),
      Kplus(),
      TiscoBank(),
      ICBCbank(),
      KrungThaiBank()
      ],
   /* "อื่นๆ": [],*/
  };

  String searchQuery = "";

  @override
  Widget build(BuildContext context) {
    List<String> filteredCategories = emergencyCategories
        .where((category) =>
            category.toLowerCase().contains(searchQuery.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: AppBar(
          centerTitle: true,
          elevation: 1,
          iconTheme: IconThemeData(
            color: Color(0xFFE0F7FA),
          ),
          automaticallyImplyLeading: true,
          flexibleSpace: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Color(0xFF0083B0),Color(0xff6849ef)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
          ),
          title: Text(
            'เบอร์โทรฉุกเฉิน',
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
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 // SizedBox(height: 5),
                  SizedBox(height: 5),
                  for (String category in filteredCategories)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            category,
                            style: GoogleFonts.kanit(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ...categoryContacts[category]!.map((contact) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: SizedBox(
                              width: double.infinity,
                              child: contact,
                            ),
                          );
                        }).toList(),
                        Divider(),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

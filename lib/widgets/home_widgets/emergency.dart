import 'package:flutter/material.dart';
import 'package:sosapp/widgets/home_widgets/emergencies/copy.dart';

import 'emergencies/AmbulanceEmergency.dart';
import 'emergencies/FirebrigadeEmergency.dart';
import 'emergencies/WaterEmergency.dart';

class Emergency extends StatelessWidget {
  const Emergency({Key? key}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 180,
      child: ListView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        children: [
          PoliceEmergency(),
          AmbulanceEmergency(),
          FirebrigadeEmergency(),
          WaterEmergency(),
        ],
      ),
    );


  }
}
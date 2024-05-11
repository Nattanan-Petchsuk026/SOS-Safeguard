import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:sosapp/main.dart';
import 'package:sosapp/widgets/bottom_screen/home_screen.dart';

class BottomPage extends StatefulWidget {
  const BottomPage({Key? key});

  @override
  State<BottomPage> createState() => _BottomPageState();
}

class _BottomPageState extends State<BottomPage> {
  int _currentIndex = 0; // Added for tracking the selected index

  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  List<Widget> pages = [
    HomeScreen(),
    MyHomePage(title: '',),
    

  ];

  @override
Widget build(BuildContext context) {
 return Scaffold(
  body: LiquidPullToRefresh(
    color: Color(0xFF0083B0),
    height: 150,
    backgroundColor: Color(0xFF00B4DB),
    onRefresh: _handleRefresh,
    child: pages[_currentIndex], // เพิ่ม LiquidPullToRefresh โดยใช้ widget ที่อยู่ใน pages ที่มี index เท่ากับ _currentIndex
  ),
  bottomNavigationBar: Container(
    decoration: BoxDecoration(
      gradient: LinearGradient(
        colors: [Color(0xFF0083B0),Color(0xff6849ef)],
        //colors: [Color(0xFF00B4DB), Color(0xFF0083B0)], before
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ), 
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        buildNavItem(FontAwesomeIcons.house, 'หน้าหลัก', 0),
        buildNavItem(FontAwesomeIcons.solidAddressBook, 'ติดต่อ', 1),
       // buildNavItem(FontAwesomeIcons.solidMessage, 'แชท', 2),
        //buildNavItem(Icons.group, 'Member', 3),
       // buildNavItem(Icons.person, 'Profile', 2),
      ],
    ),
  ),
);

}

  Widget buildNavItem(IconData icon, String label, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          _currentIndex = index; // Update the current index when tapped
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 30),
        decoration: BoxDecoration(
          color: _currentIndex == index ? Color(0xFF8C9EFF): Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: _currentIndex == index ? Colors.white : Color(0xFFE0F7FA),
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                color: _currentIndex == index ? Colors.white : Color(0xFFE0F7FA),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

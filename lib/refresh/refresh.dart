import 'package:flutter/material.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

class Refresh extends StatefulWidget {
  const Refresh({Key? key}) : super(key: key);

  @override
  _RefreshState createState() => _RefreshState();
}

class _RefreshState extends State<Refresh> {
  Future<void> _handleRefresh() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 234, 184, 153),
      body: LiquidPullToRefresh(
        color: Color.fromARGB(255, 239, 132, 38),
        height: 300,
        backgroundColor: Color.fromARGB(255, 224, 178, 113),
        onRefresh: _handleRefresh,
        child: ListView.builder(
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 300,
                    color: Color.fromARGB(255, 30, 113, 8),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:recipie/BottomNavBar.dart';
import 'package:recipie/home.dart';
import 'package:rive/rive.dart';

class HomepageScreen extends StatefulWidget {
  HomepageScreen(
      {required ThemeData Theme, required BottomNavBar HomepageScreen});
  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final List<Widget> _children = [
    home(),
    Container(
      child: Center(
        child: ImageIcon(
          AssetImage("asstes/images/image.jpeg"),
          size: 110.0,
        ),
      ),
    ),
    Container(
      color: Colors.yellow,
    ),
    Container(
      color: Colors.orange,
    ),
    Container(
      color: Colors.red,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: GNav(
          backgroundColor: Colors.black38,
          color: Color.fromARGB(255, 207, 204, 204),
          activeColor: Color.fromARGB(255, 212, 206, 206),
          tabBackgroundColor: Color.fromARGB(255, 167, 65, 130),
          gap: 8,
          padding: EdgeInsets.all(16),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Homes',
            ),
            GButton(
              icon: Icons.favorite_border,
              text: 'Likes',
            ),
            GButton(
              icon: Icons.search,
              text: 'Search',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
            ),
          ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:recipie/DetailsScreen.dart';
import 'package:recipie/HomeScreen.dart';
import 'package:recipie/MyProfileScreen.dart';
import 'package:recipie/home.dart';
import 'package:recipie/product_screen.dart';
import 'package:recipie/search.dart';
import 'package:recipie/event.dart';
import 'package:recipie/AddRecipie.dart';

class BottomNavBar extends StatefulWidget {
  int currentIndex = 0;
  BottomNavBar(this.currentIndex);
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  final List<Widget> _children = [
    ProductScreen(),
    AddRecipie(),
    EventScreen(),
    MyProfileScreen(),
  ];

  void onTabTpped(int index) {
    setState(() {
      widget.currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 17, 17, 17),
      body: _children[widget.currentIndex],
      bottomNavigationBar: Container(
        height: 64.0,
        margin: EdgeInsets.all(24.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16.0),
          child: BottomNavigationBar(
              elevation: 0.0,
              type: BottomNavigationBarType.fixed,
              showUnselectedLabels: false,
              showSelectedLabels: false,
              backgroundColor:
                  Color.fromARGB(66, 215, 207, 207).withOpacity(0.08),
              selectedItemColor: Color.fromARGB(255, 102, 203, 226),
              unselectedItemColor:
                  Color.fromARGB(255, 151, 137, 133).withOpacity(0.4),
              onTap: onTabTpped,
              currentIndex: widget.currentIndex,
              items: [
                buildBottomNavigationBarItem(
                  0,
                  "assets/icons/home.png",
                  "home",
                ),
                buildBottomNavigationBarItem(
                  1,
                  "assets/icons/icons8-add-new-100.png",
                  "add new recipie",
                ),
                buildBottomNavigationBarItem(
                    2, "assets/icons/search.png", "search"),
                buildBottomNavigationBarItem(
                  3,
                  "assets/icons/user.png",
                  "user",
                ),
              ]),
        ),
      ),
    );
  }

  BottomNavigationBarItem buildBottomNavigationBarItem(
      int index, String icon, String title) {
    return BottomNavigationBarItem(
      icon: ImageIcon(
        AssetImage(icon),
        size: 20.0,
      ),
      label: title,
    );
  }
}

Widget emptyScreen(String image, String title) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ImageIcon(
          AssetImage(image),
          size: 110.0,
          color: Colors.white,
        ),
        SizedBox(
          height: 18.0,
        ),
        Text(
          title,
          style: TextStyle(
            fontSize: 50.0,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    ),
  );
}

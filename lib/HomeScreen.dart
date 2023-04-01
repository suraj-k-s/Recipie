import 'package:flutter/material.dart';
import 'package:recipie/DetailsScreen.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen();

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  List<String> blogTypes = ["All", "Feeds", "Comments"];
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: Container(
        padding: const EdgeInsets.only(
            top: 64.0, bottom: 0.0, left: 24.0, right: 24.0),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset(
                    "assets/images/photo1676608557.jpeg",
                    height: 60.0,
                    width: 60.0,
                  ),
                  const SizedBox(
                    width: 20.0,
                  ),
                  const Expanded(
                    child: Text(
                      "Hey, Shinu..",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 22.0,
              ),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "Trending",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    TextSpan(text: "    "),
                    TextSpan(
                      text: "Foods",
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(
                    blogTypes.length,
                    (index) => GestureDetector(
                      onTap: () => setState(() {
                        selectedIndex = index;
                      }),
                      child: Padding(
                        padding: const EdgeInsets.only(right: 57.0),
                        child: Column(
                          children: [
                            Text(
                              blogTypes[index],
                              style: TextStyle(
                                fontSize: 21.0,
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.white.withOpacity(0.5),
                                fontWeight: selectedIndex == index
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                            Container(
                              height: 4.0,
                              width: 4.0,
                              margin: EdgeInsets.only(top: 8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4.0),
                                color: selectedIndex == index
                                    ? Colors.white
                                    : Colors.blueGrey.withOpacity(0.5),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 28.0,
              ),
              GestureDetector(
                onTap: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(),
                  ),
                ),
                child: Stack(
                  children: [
                    Hero(
                      tag: "Food Image",
                      child: Container(
                        height: 250.0,
                        width: size.width,
                        decoration: BoxDecoration(
                          color: Colors.amberAccent,
                          borderRadius: BorderRadius.circular(24.0),
                          image: DecorationImage(
                            image: AssetImage("assets/images/download.jpeg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 24.0,
                      right: 30.0,
                      child: Hero(
                        tag: "likes",
                        child: Container(
                          height: 42.0,
                          width: 70.0,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(50.0)),
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/icons/red-heart.png",
                                height: 20.0,
                                width: 20.0,
                              ),
                              SizedBox(width: 6.0),
                              Text(
                                "480",
                                style: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.white.withOpacity(0.75)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0.0,
                      left: 0.0,
                      right: 0.0,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 16.0, horizontal: 24.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "OATS",
                              style: TextStyle(
                                  fontSize: 20.0,
                                  color: Colors.white.withOpacity(0.75),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 10.0),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Hero(
                                  tag: "Userprofile",
                                  child: Image.asset(
                                    "assets/images/download.jpg",
                                    height: 40.0,
                                    width: 40.0,
                                  ),
                                ),
                                SizedBox(width: 12.0),
                                Expanded(
                                  child: Text(
                                    "Milly",
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white.withOpacity(0.8)),
                                  ),
                                ),
                                Text(
                                  "10 june 2023",
                                  style: TextStyle(
                                      fontSize: 20.0,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white.withOpacity(0.8)),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

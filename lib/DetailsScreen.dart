import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen();
  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                Hero(
                  tag: "Food Image",
                  child: Image.asset("assets/images/download.jpeg",
                      height: 400.0, width: size.width, fit: BoxFit.cover),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 64.0, bottom: 0.0, left: 24.0, right: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.of(context).pop(),
                        child: Container(
                          height: 60.0,
                          width: 60.0,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(221, 230, 220, 220)
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(48.0)),
                          child: Image.asset("assets/icons/arrow.png"),
                        ),
                      ),
                      Container(
                          height: 60.0,
                          width: 60.0,
                          padding: EdgeInsets.all(12.0),
                          decoration: BoxDecoration(
                              color: Color.fromARGB(221, 246, 239, 239)
                                  .withOpacity(0.3),
                              borderRadius: BorderRadius.circular(48.0)),
                          child: Image.asset("assets/icons/save.png"))
                    ],
                  ),
                )
              ],
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 16.0, horizontal: 24.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        width: size.width / 2,
                        child: Text(
                          "How to make .......",
                          style: TextStyle(
                              fontSize: 24.0,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Hero(
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
                    ],
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.black.withOpacity(0.08),
                    height: 32.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Hero(
                        tag: "UserProfile",
                        child: Image.asset(
                          "assets/images/download.jpg",
                          height: 60.0,
                          width: 60.0,
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
                  ),
                  Divider(
                    thickness: 1.0,
                    color: Colors.black.withOpacity(0.08),
                    height: 32.0,
                  ),
                  Text(
                    "Allow the powder to cool and then add little Salt (to taste) to the oats powder and mix well. To this sprinkle Water (1/2 cup) little by little and stir well with your hands. The whole mixture should be wet. You can see lumps formed. But that's perfectly fine as by the next step it hghgfyfyrteew43w3w3we5e5578r4948will be smooth.",
                    style: TextStyle(
                      fontSize: 25.0,
                      color: Colors.black.withOpacity(0.8),
                    ),
                  ),
                  Container(
                    height: 64.0,
                    width: size.width,
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 53, 69, 78),
                        borderRadius: BorderRadius.circular(12.0)),
                    child: TextField(
                        decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "write a comment...",
                            hintStyle: TextStyle(
                                color: Color.fromARGB(255, 193, 196, 169),
                                fontSize: 15.0))),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipie/ApiCall.dart';
import 'package:recipie/constants.dart';
import 'package:recipie/product_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  List imagesLarge = [];
  List textLarge = [];
  List recipieID = [];
  List descriptionText = [];
  List about = [];

  Future<void> _fetchEvents() async {
    var response = await ApiCall().get('event.php').catchError((err) {
      debugPrint(err);
    });
    if (response != 'Error') {
      List<Map<String, dynamic>> recipies =
          List<Map<String, dynamic>>.from(jsonDecode(response));

      setState(() {
        imagesLarge =
            recipies.map((recipie) => recipie['event_poster']).toList();
        recipieID = recipies.map((recipie) => recipie['event_id']).toList();

        textLarge = recipies.map((recipie) => recipie['event_title']).toList();
        descriptionText =
            recipies.map((recipie) => recipie['event_date']).toList();
        about = recipies.map((recipie) => recipie['event_details']).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(18.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Hello Text + Full Name with Icon
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Events',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ],
                  ),
                  // Profile Image
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ListView.separated(
                  shrinkWrap: true,
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      height: 10,
                    );
                  },
                  itemCount: imagesLarge.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        SharedPreferences prefs =
                            await SharedPreferences.getInstance();
                        prefs.setString('banner', poster + imagesLarge[index]);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductDetailScreen(
                              image: imagesLarge[index],
                              name: textLarge[index],
                              about: about[index],
                              ingredients: [],
                              steps: about[index],
                              buttonTitle: "Events are New",
                              aboutName: "Event",
                              recipieId: "1");
                        }));
                      },
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Color(0xff18181A),
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 5.0, right: 10.0),
                          child: Row(
                            children: [
                              Image.network(
                                '${poster + imagesLarge[index]}',
                                height: 100.0,
                                width: 100.0,
                              ),
                              const SizedBox(
                                width: 10.0,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      textLarge[index],
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 17,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Text(
                                      descriptionText[index],
                                      style: TextStyle(
                                        color: Colors.blueGrey,
                                        fontSize: 13,
                                      ),
                                      maxLines: 2,
                                    ),
                                    const SizedBox(
                                      height: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

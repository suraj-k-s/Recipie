import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipie/ApiCall.dart';
import 'package:recipie/constants.dart';
import 'package:recipie/product_detail_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SavedList extends StatefulWidget {
  const SavedList({Key? key}) : super(key: key);

  @override
  State<SavedList> createState() => _SavedListState();
}

class _SavedListState extends State<SavedList> {
  List imagesLarge = [];
  List userData = [];
  List userImage = [];
  List textLarge = [];
  List recipieID = [];
  List recipieVideo = [];
  List descriptionText = [];
  List about = [];
  List ingredients = [];
  List steps = [];
  String? _name;
  String _image = 'http://${ipAddress}/Recipie/Web/Assets/Files/User/user.png';
  String? _id;

  Future<void> _fetchRecipes(id) async {
    var response =
        await ApiCall().get('wishlist.php?uid=${id}').catchError((err) {});
    if (response != 'Error') {
      List<Map<String, dynamic>> recipies =
          List<Map<String, dynamic>>.from(jsonDecode(response));

      setState(() {
        userData = recipies.map((recipie) => recipie['user_name']).toList();
        userImage = recipies.map((recipie) => recipie['image']).toList();
        recipieVideo =
            recipies.map((recipie) => recipie['recipie_video']).toList();

        imagesLarge =
            recipies.map((recipie) => recipie['gallery_file']).toList();
        recipieID = recipies.map((recipie) => recipie['recipie_id']).toList();

        textLarge =
            recipies.map((recipie) => recipie['recipie_title']).toList();
        descriptionText =
            recipies.map((recipie) => recipie['recipie_details']).toList();
        about = recipies.map((recipie) => recipie['recipie_details']).toList();
        ingredients = recipies.map((recipie) => recipie['inc']).toList();

        steps = recipies.map((recipie) => recipie['recipie_details']).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _name = prefs.getString('name');
        _image = userImagePath + prefs.getString('image')!;
        _id = prefs.getString('id');
      });
      _fetchRecipes(prefs.getString('id'));
    });
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
                        'Hello',
                        style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      SizedBox(
                        height: 5.0,
                      ),
                      Row(
                        children: [
                          // Name Text
                          Text(
                            _name ?? '',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            width: 10.0,
                          ),
                          // Hello Icon
                          Image.asset(
                            'assets/images/goodbye.png',
                            height: 25,
                            width: 25,
                          ),
                        ],
                      ),
                    ],
                  ),
                  // Profile Image
                  ClipRRect(
                    child: GestureDetector(
                        child: Image.network(
                      _image,
                      height: 70,
                      width: 70,
                    )),
                  )
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
                        prefs.setString(
                            'banner', galleryPath + imagesLarge[index]);
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return ProductDetailScreen(
                              image: imagesLarge[index],
                              name: textLarge[index],
                              about: about[index],
                              ingredients: ingredients[index],
                              steps: steps[index],
                              buttonTitle: "Cooking Steps",
                              aboutName: "Recipie",
                              recipieId: recipieID[index]);
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
                                '${galleryPath + imagesLarge[index]}',
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
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          userData[index],
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w800,
                                              fontStyle: FontStyle.italic,
                                              fontSize: 15),
                                        ),
                                        Image.network(
                                          '${userImagePath + userImage[index]}',
                                          height: 30.0,
                                          width: 30.0,
                                        ),
                                      ],
                                    ),
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

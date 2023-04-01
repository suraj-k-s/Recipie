import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recipie/BottomNavBar.dart';
import 'package:recipie/comment.dart';
import 'package:recipie/constants.dart';
import 'package:recipie/product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';
import 'dart:convert';
import 'package:recipie/ApiCall.dart';

class ProductDetailScreen extends StatefulWidget {
  ProductDetailScreen(
      {Key? key,
      required this.image,
      required this.name,
      required this.about,
      required this.ingredients,
      required this.steps,
      required this.buttonTitle,
      required this.recipieId,
      required this.aboutName})
      : super(key: key);

  String image;
  String name;
  String about;
  List ingredients;
  String steps;
  String aboutName;
  String recipieId;
  String buttonTitle = 'Loding...';

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String banner = 'http://${ipAddress}/Recipie/Web/Assets/Files/User/user.png';

  late String _id;
  String count = '0';
  String status = "false";

  Future<void> _fetchLike() async {
    var response = await ApiCall()
        .get('like.php?id=${widget.recipieId}')
        .catchError((err) {
      debugPrint(err);
    });

    if (response != 'Error') {
      setState(() {
        count = response;
      });
    }
  }

  Future<void> _fetchFind(id) async {
    var response = await ApiCall()
        .get('like.php?id=${widget.recipieId}&uid=${id}')
        .catchError((err) {
      debugPrint(err);
    });
    if (response != 'Error') {
      setState(() {
        status = response;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        banner = prefs.getString('banner')!;
        _id = prefs.getString('id')!;
      });
      _fetchFind(prefs.getString('id'));
    });
    _fetchLike();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.10),
        leading: IconButton(
          color: Colors.yellow.shade200,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BottomNavBar(0))),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        centerTitle: true,
        title: Text(widget.name),
        actions: <Widget>[],
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              const SizedBox(
                height: 20.0,
              ),
              Image.network(
                banner,
                height: 100.0,
                width: 200.0,
              ),
              const SizedBox(
                height: 10.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    border: Border(
                      left: BorderSide(width: 1.5, color: Colors.white),
                      top: BorderSide(width: 1.5, color: Colors.white),
                      right: BorderSide(width: 1.5, color: Colors.white),
                      bottom: BorderSide(width: 1.5, color: Colors.white),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.thumb_up_sharp,
                                color: status == "true"
                                    ? Colors.red
                                    : Colors.white,
                              ),
                              onPressed: () async {
                                var obj = {
                                  'recipie_id': widget.recipieId,
                                  'user_id': _id
                                };
                                final response = await ApiCall()
                                    .post('like.php', obj)
                                    .catchError((err) {
                                  debugPrint(err);
                                });
                                _fetchLike();
                                setState(() {
                                  status = status == "true" ? "false" : "true";
                                });
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text('like ' + count,
                                style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.save_rounded,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                var obj = {
                                  'recipie_id': widget.recipieId,
                                  'user_id': _id
                                };
                                final response = await ApiCall()
                                    .post('wishlist.php', obj)
                                    .catchError((err) {
                                  debugPrint(err);
                                });
                                print(response);
                                if (response == "inserted") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Added To WishList"),
                                  ));
                                } else if (response == "Deleted") {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Removed From WishList"),
                                  ));
                                } else {
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(SnackBar(
                                    content: Text("Failed"),
                                  ));
                                }
                              },
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            Text('Save', style: TextStyle(color: Colors.grey)),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: MaterialButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0)),
                  minWidth: MediaQuery.of(context).size.width,
                  height: 60.0,
                  color: Colors.yellow.shade200,
                  onPressed: () {
                    bottomScrollSheet();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        widget.buttonTitle,
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        width: 60,
                      ),
                      ClipRRect(
                          borderRadius: BorderRadius.circular(27.0),
                          child: Image.asset(
                            'assets/images/cook.gif',
                            height: 54,
                            width: 54,
                          )),
                    ],
                  ),
                ),
              ),
              Text(
                'About This ${widget.aboutName}',
                style: TextStyle(
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
                child: Text(
                  widget.about,
                  style: TextStyle(color: Colors.white, fontSize: 14),
                  textAlign: TextAlign.justify,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future bottomScrollSheet() {
    List ingredients = widget.ingredients;
    return showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height / 2.5,
              decoration: const BoxDecoration(
                  color: Color(0xff18181A),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40.0),
                      topRight: Radius.circular(40.0))),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        'Ingredients',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            for (var ingredient in ingredients) ...[
                              const SizedBox(
                                width: 10,
                              ),
                              Image.network(
                                inc + ingredient['ingredient_photo'],
                                height: 40.0,
                                width: 40.0,
                              )
                            ]
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Text(
                        'Steps',
                        style: TextStyle(
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.about,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

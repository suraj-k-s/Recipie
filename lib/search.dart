import 'package:flutter/material.dart';
import 'package:get/get_connect/sockets/src/socket_notifier.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recipie/model/food_model.dart';

import 'BottomNavBar.dart';

class search extends StatefulWidget {
  search();

  @override
  _searchState createState() => _searchState();
}

class _searchState extends State<search> {
  static List<food_model> main_food_list = [
    food_model("banana smoothie"),
    food_model("shake")
  ];
  List<food_model> display_list = List.from(main_food_list);

  void updateList(String value) {
    //function filters our list
    setState(() {
      display_list = main_food_list
          .where((element) =>
              element.food_caption!.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        leading: IconButton(
          color: Colors.yellow.shade200,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BottomNavBar(0))),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: const Text(
          " Search Your Favourite Food",
          style: TextStyle(color: Color.fromARGB(255, 151, 145, 91)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.0,
              ),
              TextField(
                onChanged: (value) => updateList(value),
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Color.fromARGB(137, 229, 222, 222),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none),
                    hintText: "eg: smoothie",
                    prefixIcon: Icon(Icons.search),
                    prefixIconColor: Color.fromARGB(255, 209, 200, 118)),
              ),
              SizedBox(
                height: 20.0,
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: display_list.length,
                    itemBuilder: (context, index) => ListTile(
                          contentPadding: EdgeInsets.all(8.0),
                          title: Text(
                            display_list[index].food_caption!,
                            style: TextStyle(
                                color: Color.fromARGB(255, 226, 219, 219),
                                fontWeight: FontWeight.bold),
                          ),
                        )),
              ),
            ]),
      ),
    );
  }
}

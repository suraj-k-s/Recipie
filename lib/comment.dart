import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recipie/BottomNavBar.dart';
import 'package:recipie/product_detail_screen.dart';
import 'package:recipie/product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import 'constants.dart';

class comment extends StatefulWidget {
  comment();
  @override
  _comment createState() => _comment();
}

class _comment extends State<comment> {
  final _formKey = GlobalKey<FormState>();
  final _commentController = TextEditingController();

  void insertcomment() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://${ipAddress}/Recipie/Web/Api/comment.php'));
    request.fields['comment_id'] = prefs.getString("comment_id").toString();
    request.fields['content'] = _commentController.text;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
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
            " Comments",
            style: TextStyle(color: Color.fromARGB(255, 151, 145, 91)),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 52),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 74, 79, 79)),
                child: TextField(
                  controller: _commentController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    hintText: "comment",
                    suffixIcon: IconButton(
                      icon: Icon(
                        size: 30,
                        Icons.keyboard_double_arrow_right_rounded,
                        color: Colors.yellow.shade200,
                      ),
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return comment();
                          },
                        ),
                      ),
                    ),
                    prefixIcon: const Icon(Icons.comment_bank_outlined),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            )));
  }
}

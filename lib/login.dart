import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:recipie/BottomNavBar.dart';
import 'package:recipie/registration.dart';
import 'package:rive/rive.dart';
import 'package:recipie/ApiCall.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  StateMachineController? controller;

  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 75, 73, 73).withOpacity(0.1),
      body: SizedBox(
        width: size.width,
        height: size.height,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 5,
              ),
              Padding(padding: EdgeInsets.all(0)),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Login",
                    style:
                        TextStyle(color: Colors.yellow.shade200, fontSize: 50),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 226, 223, 223).withOpacity(0.5)),
                child: TextField(
                  controller: _email,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    hintText: "E mail",
                    prefixIcon: const Icon(Icons.mail),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromARGB(255, 226, 223, 223).withOpacity(0.5)),
                child: TextField(
                  controller: _password,
                  obscureText: true, // to hide password
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              MaterialButton(
                minWidth: size.width,
                height: 50,
                color: Color.fromARGB(255, 79, 75, 75),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                onPressed: () async {
                  var email = _email.text;
                  var password = _password.text;

                  //
                  var obj = {'user_email': email, 'user_password': password};

                  final response =
                      await ApiCall().post('login.php', obj).catchError((err) {
                    debugPrint(err);
                  });
                  if (response == "Error") {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Invalid Credentials"),
                    ));
                  } else {
                    Map<String, dynamic> responseData = json.decode(response);
                    String userId = responseData['user_id'];
                    String userName = responseData['user_name'];
                    String userImage = responseData['image'];

                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    prefs.setString('id', userId);
                    prefs.setString('name', userName);
                    prefs.setString('image', userImage);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("Login Successful"),
                    ));
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: ((context) {
                      return MaterialApp(
                        debugShowCheckedModeBanner: false,
                        theme: ThemeData(
                          primaryColor: Colors.brown,
                          primarySwatch: Colors.lime,
                          visualDensity: VisualDensity.adaptivePlatformDensity,
                        ),
                        home: BottomNavBar(0),
                      );
                    })));
                  }
                },
                child: const Text(
                  "Login",
                  style: TextStyle(color: Color.fromARGB(255, 209, 200, 118)),
                ),
              ),
              const SizedBox(height: 10),
              SizedBox(
                width: size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't you have an account?",
                      style: TextStyle(
                        color: Color.fromARGB(255, 209, 200, 118),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return RegistartionScreen();
                            },
                          ),
                        );
                      },
                      // todo register

                      child: const Text(
                        "Register",
                        style: TextStyle(
                            color: Color.fromARGB(255, 209, 200, 118)),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

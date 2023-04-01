import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:recipie/login.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:recipie/ApiCall.dart';
import 'package:recipie/constants.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class RegistartionScreen extends StatefulWidget {
  const RegistartionScreen({super.key});

  @override
  State<RegistartionScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistartionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _contactController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _placeController = TextEditingController();

  XFile? _userPhoto;

  @override
  void dispose() {
    _usernameController.dispose();
    _contactController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _placeController.dispose();
    super.dispose();
  }

  StateMachineController? controller;

  TextEditingController _name = TextEditingController();
  TextEditingController _contact = TextEditingController();
  TextEditingController _place = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();

  SMIInput<bool>? isChecking;
  SMIInput<bool>? isHandsUp;
  SMIInput<bool>? trigSuccess;
  SMIInput<bool>? trigFail;
  void userImage() async {
    final pickedPhotos =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedPhotos != null) {
      setState(() {
        _userPhoto = pickedPhotos;
      });
    }
  }

  void registerUser() async {
    var name = _name.text;
    var contact = _contact.text;
    var place = _place.text;
    var password = _password.text;
    var email = _email.text;

    var request = http.MultipartRequest(
        'POST', Uri.parse('http://${ipAddress}/Recipie/Web/Api/User.php'));
    request.fields['user_name'] = name;
    request.fields['user_contact'] = contact;
    request.fields['user_place'] = place;
    request.fields['user_email'] = email;
    request.fields['user_password'] = password;
    request.files
        .add(await http.MultipartFile.fromPath('image', _userPhoto!.path));
    var response = await request.send();
    final respStr = await response.stream.bytesToString();
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Registration Successful"),
      ));
      Navigator.pushReplacement(context, MaterialPageRoute(builder: ((context) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: Colors.brown,
            primarySwatch: Colors.lime,
            visualDensity: VisualDensity.adaptivePlatformDensity,
          ),
          home: LoginScreen(),
        );
      })));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please Try Again"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 10, 10, 10),
        body: SizedBox(
            width: size.width,
            height: size.height,
            child: Padding(
                padding: const EdgeInsets.only(top: 100, left: 12, right: 12),
                child: SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(height: 20),
                        Text(
                          "Register here....",
                          style: TextStyle(
                              fontSize: 30,
                              color: Color.fromARGB(255, 209, 200, 118)),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 226, 223, 223)
                                  .withOpacity(0.5)),
                          child: TextFormField(
                            controller: _name,
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              hintText: "Name",
                              prefixIcon: const Icon(Icons.person),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please choose a username';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 226, 223, 223)
                                  .withOpacity(0.5)),
                          child: TextFormField(
                            controller: _contact,
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              hintText: "Contact Number",
                              prefixIcon: const Icon(Icons.call),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please enter valid contact number';
                              } else if (value.length > 10) {
                                return 'enter valid phone number';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 226, 223, 223)
                                  .withOpacity(0.5)),
                          child: TextFormField(
                            controller: _place,
                            keyboardType: TextInputType.streetAddress,
                            decoration: InputDecoration(
                              hintText: "Place",
                              prefixIcon: const Icon(Icons.home),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'please choose a place';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 226, 223, 223)
                                  .withOpacity(0.5)),
                          child: TextFormField(
                            controller: _email,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              hintText: "E mail",
                              prefixIcon: const Icon(Icons.mail),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              Color:
                              Colors.white;
                              if (value == null || value.isEmpty) {
                                return 'please enter email id';
                              } else if (!value.contains("@") ||
                                  !value.contains(".")) {
                                return "please eneter a valid email id";
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              color: Color.fromARGB(255, 226, 223, 223)
                                  .withOpacity(0.5)),
                          child: TextFormField(
                            controller: _password,
                            obscureText: true, // to hide password
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: const Icon(Icons.lock),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            validator: (value) {
                              Color:
                              Colors.white;
                              if (value == null || value.isEmpty) {
                                return 'Please enter your password';
                              } else if (value.length < 6) {
                                return 'Password must be at least 6 characters long';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(height: 10),
                        MaterialButton(
                          minWidth: size.width,
                          height: 50,
                          color: Color.fromARGB(255, 226, 223, 223)
                              .withOpacity(0.5),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () async {
                            userImage();
                          },
                          child: _userPhoto != null
                              ? Text(
                                  "File Choosed",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 209, 200, 118)),
                                )
                              : Text(
                                  "Upload Photo",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 209, 200, 118)),
                                ),
                        ),
                        const SizedBox(height: 20),
                        const SizedBox(height: 10),
                        MaterialButton(
                          minWidth: size.width,
                          height: 50,
                          color: Color.fromARGB(255, 79, 75, 75),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          onPressed: () {
                            if (_name.text == null || _name.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Fill Name Field"),
                              ));
                              return;
                            } else if (_contact.text == null ||
                                _contact.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Fill Contact Field"),
                              ));

                              return;
                            } else if (_place.text == null ||
                                _place.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Fill Place Field"),
                              ));
                              return;
                            } else if (_email.text == null ||
                                _email.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Fill EMail Field"),
                              ));
                              return;
                            } else if (_password.text == null ||
                                _password.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Fill Password Field"),
                              ));
                              return;
                            } else if (_userPhoto?.path == null) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text("Choose User Photo"),
                              ));
                              return;
                            }
                            registerUser();
                          },
                          child: const Text(
                            "Register",
                            style: TextStyle(
                                color: Color.fromARGB(255, 209, 200, 118)),
                          ),
                        ),
                        const SizedBox(height: 10),
                        SizedBox(
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                "Already have an account Login here....",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 209, 200, 118)),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return LoginScreen();
                                      },
                                    ),
                                  );
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color:
                                          Color.fromARGB(255, 209, 200, 118)),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ))));
  }
}

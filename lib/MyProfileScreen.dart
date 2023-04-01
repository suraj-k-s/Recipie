import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recipie/ApiCall.dart';
import 'package:recipie/BottomNavBar.dart';
import 'package:recipie/SavedList.dart';

import 'package:recipie/UpdateProfileScreen.dart';
import 'package:get/get.dart';
import 'package:recipie/changepassword.dart';
import 'package:recipie/constants.dart';
import 'package:recipie/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfileScreen> {
  List userImage = [];
  String _image = 'http://${ipAddress}/Recipie/Web/Assets/Files/User/user.png';
  int? _id;

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _image = userImagePath + prefs.getString('image')!;
      });
    });
  }

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      File _selectedFile = File(result.files.single.path ?? '');

      var response = await ApiCall().post('user.php', "dat").catchError((err) {
        debugPrint(err);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var isDark = MediaQuery.of(context).platformBrightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.yellow.shade200,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BottomNavBar(0))),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: const Text(
          " Profile",
          style: TextStyle(color: Color.fromARGB(255, 219, 207, 100)),
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(isDark ? LineAwesomeIcons.sun : LineAwesomeIcons.moon),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      width: 120,
                      height: 120,
                      child: InkWell(
                        onTap: () {
                          _pickFile();
                        },
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.network(_image),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.green.withOpacity(0.1),
                        ),
                        child: const Icon(
                          LineAwesomeIcons.camera,
                          size: 20.0,
                          color: Color.fromARGB(255, 17, 17, 17),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(height: 20),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: () => Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) => UpdateProfileScreen())),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 13, 13, 13),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "Edit Profile",
                      style: TextStyle(color: Colors.yellow),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Divider(),

                //menu
                ListTile(
                  onTap: () => Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => changepassword())),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color:
                          Color.fromARGB(255, 231, 230, 233).withOpacity(0.1),
                    ),
                  ),
                ),
                ListTile(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => SavedList()));
                  },
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 98, 7, 255)
                          .withOpacity(0.1),
                    ),
                    child: const Icon(
                      LineAwesomeIcons.save,
                      color: Colors.black,
                    ),
                  ),
                  title: Text("Saved Items",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.red)),
                  trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      child: const Icon(
                        LineAwesomeIcons.angle_right,
                        size: 18.0,
                        color: Colors.grey,
                      )),
                ),

                ListTile(
                  onTap: () => Navigator.of(context).push(
                      MaterialPageRoute(builder: (context) => LoginScreen())),
                  leading: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: const Color.fromARGB(255, 98, 7, 255)
                          .withOpacity(0.1),
                    ),
                    child: const Icon(
                      LineAwesomeIcons.alternate_sign_out,
                      color: Colors.black,
                    ),
                  ),
                  title: Text("Logout",
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          ?.apply(color: Colors.red)),
                  trailing: Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: Colors.green.withOpacity(0.1),
                      ),
                      child: const Icon(
                        LineAwesomeIcons.angle_right,
                        size: 18.0,
                        color: Colors.grey,
                      )),
                ),
              ],
            )),
      ),
    );
  }
}

// ignore: camel_case_types
class profileMenuWidget extends StatelessWidget {
  const profileMenuWidget({
    Key? key,
    required this.title,
    required this.icon,
    required this.onPress,
    this.endIcon = true,
    this.textColor,
  }) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onPress;
  final bool endIcon;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPress,
      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(100),
          color: const Color.fromARGB(255, 98, 7, 255).withOpacity(0.1),
        ),
        child: const Icon(
          LineAwesomeIcons.cog,
          color: Colors.black,
        ),
      ),
      title: Text(title,
          style:
              Theme.of(context).textTheme.bodyText1?.apply(color: textColor)),
      trailing: endIcon
          ? Container(
              width: 30,
              height: 30,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Colors.green.withOpacity(0.1),
              ),
              child: const Icon(
                LineAwesomeIcons.angle_right,
                size: 18.0,
                color: Colors.grey,
              ))
          : null,
    );
  }
}

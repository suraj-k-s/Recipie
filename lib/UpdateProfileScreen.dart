import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recipie/ApiCall.dart';
import 'package:recipie/MyProfileScreen.dart';
import 'package:recipie/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);
  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreen();
}

class _UpdateProfileScreen extends State<UpdateProfileScreen> {
  String _image = 'http://${ipAddress}/Recipie/Web/Assets/Files/User/user.png';
  String id = "";
  late List name;
  late List email;
  late List number;
  late List place;
  late XFile _userPhoto;

  String nameController = "";
  String emailController = "";
  String numberController = "";
  String placeController = "";

  void pickVideo() async {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _userPhoto = pickedImage;
      });
    }
  }

  Future<void> _fetchRecipes(id) async {
    var response =
        await ApiCall().get('user.php?id=${id}').catchError((err) {});
    if (response != 'Error') {
      List<Map<String, dynamic>> usres =
          List<Map<String, dynamic>>.from(jsonDecode(response));
      setState(() {
        name = usres.map((user) => user['user_name']).toList();
        email = usres.map((user) => user['user_email']).toList();
        number = usres.map((user) => user['user_contact']).toList();
        place = usres.map((user) => user['user_place']).toList();
      });
    }
  }

  @override
  void initState() {
    super.initState();

    SharedPreferences.getInstance().then((prefs) {
      setState(() {
        _image = userImagePath + prefs.getString('image')!;
        id = prefs.getString('id')!;
      });
      _fetchRecipes(prefs.getString('id'));
    });
  }

  void insertRecipie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var request = http.MultipartRequest('POST',
        Uri.parse('http://${ipAddress}/Recipie/Web/Api/UserUpdate.php'));
    request.fields['id'] = prefs.getString("id").toString();
    request.fields['name'] = nameController;
    request.fields['email'] = emailController;
    request.fields['place'] = placeController;
    request.fields['number'] = numberController;
    request.files
        .add(await http.MultipartFile.fromPath('photo', _userPhoto.path));
    var response = await request.send();
    print(response.statusCode);
    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Updated"),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something Worng"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          color: Colors.amber,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyProfileScreen())),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: Text(" Profile", style: TextStyle(color: Colors.amberAccent)),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(LineAwesomeIcons.moon),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: Column(children: [
            Stack(
              children: [
                SizedBox(
                  width: 120,
                  height: 120,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.network(_image)),
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
                      child: InkWell(
                        child: Icon(
                          LineAwesomeIcons.camera,
                          size: 20.0,
                          color: Colors.grey,
                        ),
                        onTap: () {
                          pickVideo();
                        },
                      )),
                ),
              ],
            ),
            const SizedBox(
              height: 50,
            ),
            Form(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Name"),
                      prefixIcon: Icon(LineAwesomeIcons.user)),
                  initialValue: name[0],
                  onChanged: (val) {
                    setState(() => {nameController = val});
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                    label: Text("Email"),
                    prefixIcon: Icon(LineAwesomeIcons.envelope_1),
                  ),
                  initialValue: email[0],
                  onChanged: (val) {
                    setState(() => {emailController = val});
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Phone Number"),
                      prefixIcon: Icon(LineAwesomeIcons.phone)),
                  initialValue: number[0],
                  onChanged: (val) {
                    setState(() => {numberController = val});
                  },
                ),
                const SizedBox(height: 20),
                TextFormField(
                  decoration: const InputDecoration(
                      label: Text("Place"),
                      prefixIcon: Icon(LineAwesomeIcons.building)),
                  initialValue: place[0],
                  onChanged: (val) {
                    setState(() => {placeController = val});
                  },
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: 300,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      insertRecipie();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 10, 10, 10),
                        side: BorderSide.none,
                        shape: const StadiumBorder()),
                    child: const Text(
                      "Submit",
                      style:
                          TextStyle(color: Color.fromARGB(255, 187, 215, 25)),
                    ),
                  ),
                ),
              ],
            ))
          ]),
        ),
      ),
    );
  }
}

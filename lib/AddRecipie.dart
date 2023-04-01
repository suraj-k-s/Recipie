import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:recipie/constants.dart';
import 'package:recipie/search.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'BottomNavBar.dart';

class AddRecipie extends StatefulWidget {
  AddRecipie();

  @override
  _AddRecipie createState() => _AddRecipie();
}

class _AddRecipie extends State<AddRecipie> {
  final _formKey = GlobalKey<FormState>();
  final _recipeTitleController = TextEditingController();
  final _recipeDescriptionController = TextEditingController();
  XFile? _recipeVideo;
  List<XFile>? _ingredientPhotos;
  List<XFile>? _galleryImages;

  void pickVideo() async {
    final pickedVideo =
        await ImagePicker().pickVideo(source: ImageSource.gallery);
    if (pickedVideo != null) {
      setState(() {
        _recipeVideo = pickedVideo;
      });
    }
  }

  void pickIngredientPhotos() async {
    final pickedPhotos = await ImagePicker().pickMultiImage();
    if (pickedPhotos != null) {
      setState(() {
        _ingredientPhotos = pickedPhotos;
      });
    }
  }

  void pickGalleryImages() async {
    final pickedImages = await ImagePicker().pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        _galleryImages = pickedImages;
      });
    }
  }

  void insertRecipie() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // List<String> galleryUrls = [];
    //   if (_gallery != null) {
    //     for (File file in _gallery!) {
    //       var request = http.MultipartRequest('POST', Uri.parse('http://example.com/upload-gallery'));
    //       request.files.add(await http.MultipartFile.fromPath('file', file.path));
    //       var response = await request.send();
    //       if (response.statusCode == 200) {
    //         String url = await response.stream.bytesToString();
    //         galleryUrls.add(url);
    //       }
    //     }
    //   }

    // Send recipe data to server
    var rStatus = false;
    var gStatus = false;
    var iStatus = false;
    var request = http.MultipartRequest(
        'POST', Uri.parse('http://${ipAddress}/Recipie/Web/Api/recipie.php'));
    request.fields['id'] = prefs.getString("id").toString();
    request.fields['title'] = _recipeTitleController.text;
    request.fields['description'] = _recipeDescriptionController.text;
    request.files
        .add(await http.MultipartFile.fromPath('video', _recipeVideo!.path));
    var response = await request.send();
    if (response.statusCode == 200) {
      rStatus = true;
      String id = await response.stream.bytesToString();
      if (_ingredientPhotos != null) {
        for (XFile file in _ingredientPhotos!) {
          var request = http.MultipartRequest('POST',
              Uri.parse('http://${ipAddress}/Recipie/Web/Api/ingredients.php'));
          request.files
              .add(await http.MultipartFile.fromPath('file', file.path));
          request.fields['id'] = id;
          var response = await request.send();
          if (response.statusCode == 200) {
            iStatus = true;
          }
        }
      }
      if (_galleryImages != null) {
        for (XFile file in _galleryImages!) {
          var request = http.MultipartRequest('POST',
              Uri.parse('http://${ipAddress}/Recipie/Web/Api/gallery.php'));
          request.files
              .add(await http.MultipartFile.fromPath('file', file.path));
          request.fields['id'] = id;
          var response = await request.send();
          if (response.statusCode == 200) {
            gStatus = true;
          }
        }
      }
      if (rStatus && gStatus && iStatus) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Recipie Added"),
        ));
      }
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black.withOpacity(0.5),
        leading: IconButton(
          color: Colors.yellow.shade200,
          onPressed: () => Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => BottomNavBar(0))),
          icon: const Icon(LineAwesomeIcons.angle_left),
        ),
        title: const Text(
          " Add Recipie here...",
          style: TextStyle(color: Color.fromARGB(255, 151, 145, 91)),
        ),
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(children: [
            Padding(padding: EdgeInsets.all(0)),
            SizedBox(
                height: size.height - 200,
                width: size.width,
                child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 13,
                    ),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 226, 223, 223)
                                    .withOpacity(0.5)),
                            child: TextFormField(
                              controller: _recipeTitleController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter recipe title';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.name,
                              decoration: InputDecoration(
                                hintText: "Recipie Title",
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: const Icon(Icons.title),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Color.fromARGB(255, 226, 223, 223)
                                    .withOpacity(0.5)),
                            child: TextFormField(
                              controller: _recipeDescriptionController,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter recipe description';
                                }
                                return null;
                              },
                              keyboardType: TextInputType.text,
                              decoration: InputDecoration(
                                hintText: "Description",
                                hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                prefixIcon: const Icon(Icons.note_rounded),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    MaterialButton(
                                      height: 50,
                                      minWidth: 385,
                                      color: Color.fromARGB(252, 130, 124, 124),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      onPressed: () {
                                        pickVideo();
                                      },
                                      child: _recipeVideo != null
                                          ? const Text(
                                              "Video Choosed",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )
                                          : const Text(
                                              "Choose video",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    MaterialButton(
                                      height: 50,
                                      minWidth: 385,
                                      color: Color.fromARGB(252, 130, 124, 124),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      onPressed: () {
                                        pickIngredientPhotos();
                                      },
                                      child: _ingredientPhotos != null
                                          ? const Text(
                                              "Incredients Photos are Choosed",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )
                                          : const Text(
                                              "Choose Incredients Photos",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Container(
                            height: 50,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    MaterialButton(
                                      height: 50,
                                      minWidth: 385,
                                      color: Color.fromARGB(252, 130, 124, 124),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12)),
                                      onPressed: () {
                                        pickGalleryImages();
                                      },
                                      child: _galleryImages != null
                                          ? const Text(
                                              "Gallery Images are Choosed",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            )
                                          : const Text(
                                              "Choose Gallery Images",
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.black),
                                            ),
                                    ),
                                  ],
                                ),
                              ],
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
                              if (_recipeTitleController.text == null ||
                                  _recipeTitleController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("title must be filled"),
                                ));
                                return;
                              } else if (_recipeDescriptionController.text ==
                                      null ||
                                  _recipeDescriptionController.text.isEmpty) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("Fill description Field"),
                                ));
                                return;
                              } else if (_recipeVideo?.path == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("choose video"),
                                ));
                                return;
                              } else if (_ingredientPhotos == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("choose Incredients"),
                                ));
                                return;
                              } else if (_galleryImages == null) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text("choose Gallery"),
                                ));
                                return;
                              } else {
                                insertRecipie();
                              }
                            },
                            child: const Text(
                              "Submit",
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          const SizedBox(height: 10),
                        ]))),
          ]),
        ),
      ),
    );
  }
}

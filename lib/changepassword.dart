import 'package:flutter/material.dart';
import 'package:recipie/MyProfileScreen.dart';

class changepassword extends StatefulWidget {
  @override
  _changepassword createState() => _changepassword();
}

class _changepassword extends State<changepassword> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.black,
        body: SizedBox(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "change your password now!!!",
                    style: TextStyle(
                        fontSize: 25,
                        color: Color.fromARGB(255, 209, 200, 118)),
                  ),
                  const SizedBox(height: 10),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 226, 223, 223)
                            .withOpacity(0.5)),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Current Password",
                        prefixIcon: const Icon(Icons.password),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 226, 223, 223)
                            .withOpacity(0.5)),
                    child: TextField(
                      obscureText: true, // to hide password
                      decoration: InputDecoration(
                        hintText: "New Password",
                        prefixIcon: const Icon(Icons.lock),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color.fromARGB(255, 226, 223, 223)
                            .withOpacity(0.5)),
                    child: TextField(
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: "Confirm New Password",
                        prefixIcon: const Icon(Icons.lock_open),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
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
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => MyProfileScreen()));
                    },
                    child: const Text(
                      "Submit",
                      style:
                          TextStyle(color: Color.fromARGB(255, 209, 200, 118)),
                    ),
                  ),
                ]),
          ),
        ));
  }
}

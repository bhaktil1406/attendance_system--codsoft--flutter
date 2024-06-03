import 'dart:math';

import 'package:attendance_system/auth/auth.dart';
import 'package:attendance_system/home.dart';
import 'package:attendance_system/loginpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class register extends StatelessWidget {
  final name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  final id = TextEditingController();
  final dep = TextEditingController();
  final sem = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void regi() async {
      try {
        final UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: email.text, password: pass.text);

        if (userCredential.user != null) {
          final User? user = userCredential.user;
          await authService().saveUser(
            name.text,
            email.text,
            pass.text,
            id.text,
            dep.text,
            sem.text,
            user!.uid,
          );
          print("User created");
          Navigator.push(
            context,
            MaterialPageRoute(builder: (BuildContext context) {
              return homepage();
            }),
          );
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("register successfully")));
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("User creation failed")));
          print("User creation failed");
        }
      } catch (e) {
        print("An error occurred: $e");
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        shadowColor: Colors.purple,
        elevation: 4,
        iconTheme: IconThemeData(
          color: Colors.purple,
          size: 25,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(15),
          ),
        ),
        title: Center(
          child: Text(
            "Register page",
            style: TextStyle(
                color: Colors.purple,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/9.jpg",
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                  // Container(
                  //   child: Text(
                  //     "Register",
                  //     style: TextStyle(
                  //       fontSize: 30,
                  //       fontWeight: FontWeight.bold,
                  //     ),
                  //   ),
                  // ),
                  // Container(
                  //   child: Text(
                  //     "If you are new user Register now",
                  //     style: TextStyle(
                  //       fontSize: 15,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 5, left: 15, right: 15, bottom: 10),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 220, 94, 85),
                      Color.fromARGB(255, 172, 48, 226)
                    ],
                    begin: Alignment.topCenter,
                  ),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color:
                          Color.fromARGB(255, 196, 193, 193).withOpacity(0.9),
                      spreadRadius: 6,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        child: Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
                          "If you are new user Register now",
                          style: TextStyle(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 229, 210, 232),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: name,
                            decoration: InputDecoration(
                              hintText: "Name",
                              prefixIcon: Icon(Icons.person),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 229, 210, 232),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: email,
                            decoration: InputDecoration(
                              hintText: "Email",
                              prefixIcon: Icon(Icons.email_rounded),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 229, 210, 232),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: pass,
                            decoration: InputDecoration(
                              hintText: "Password",
                              prefixIcon: Icon(Icons.password),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 229, 210, 232),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: id,
                            decoration: InputDecoration(
                              hintText: "Id",
                              focusColor: Colors.black,
                              hoverColor: Colors.black,
                              fillColor: Colors.black,
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 229, 210, 232),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: dep,
                            decoration: InputDecoration(
                              hintText: "Department",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Container(
                          padding: EdgeInsets.all(5),
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 229, 210, 232),
                              borderRadius: BorderRadius.circular(30)),
                          child: TextField(
                            controller: sem,
                            decoration: InputDecoration(
                              hintText: "Semester",
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: (() async => regi()),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Container(
                            height: 45,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color.fromARGB(255, 229, 210, 232),
                                borderRadius: BorderRadius.circular(30)),
                            child: Center(
                              child: Text(
                                "Register",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: Container(
                  child: RichText(
                text: TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                        text: 'already register?',
                        style: TextStyle(color: Colors.black, fontSize: 18)),
                    TextSpan(
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: ((context) => login())));
                          },
                        text: ' login here',
                        style: TextStyle(
                            color: Colors.purple,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              )),
            ),
          ],
        ),
      ),
    );
  }
}

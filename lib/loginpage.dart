import 'package:attendance_system/AttendanceDataPage.dart';
import 'package:attendance_system/auth/auth.dart';
import 'package:attendance_system/home.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class login extends StatelessWidget {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    void si() async {
      final user = await authService()
          .loginUserWithEmailAndPassword(email.text, pass.text, context);
      if (user != null) {
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => homepage()));
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Login successfully")));
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
            "Login Page",
            style: TextStyle(
                color: Colors.purple,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20, vertical: 100),
              child: Container(
                padding: EdgeInsets.all(10),
                height: 400,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
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
                child: Column(
                  children: [
                    Container(
                      child: Text(
                        "login here",
                        style: TextStyle(fontSize: 30),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
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
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: Color.fromARGB(255, 229, 210, 232),
                            borderRadius: BorderRadius.circular(30)),
                        child: TextField(
                          controller: pass,
                          decoration: InputDecoration(
                            hintText: "Password",
                            prefixIcon: Icon(Icons.password),
                            enabledBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                            focusedBorder:
                                OutlineInputBorder(borderSide: BorderSide.none),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: (() async {
                        if (email.text == "admin@gmail.com" &&
                            pass.text == "admin123") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AttendanceDataPage(),
                              ));
                        } else {
                          si();
                        }
                      }),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          height: 45,
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Color.fromARGB(255, 229, 210, 232),
                              borderRadius: BorderRadius.circular(30)),
                          child: Center(
                            child: Text(
                              "login",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 20),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

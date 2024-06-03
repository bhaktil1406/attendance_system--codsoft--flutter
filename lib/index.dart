import 'package:attendance_system/loginpage.dart';
import 'package:attendance_system/register.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class index extends StatelessWidget {
  const index({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          // gradient: LinearGradient(
          //   colors: [
          //     Color.fromARGB(255, 220, 94, 85),
          //     Color.fromARGB(255, 172, 48, 226)
          //   ],
          //   begin: Alignment.topCenter,
          // ),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(255, 196, 193, 193).withOpacity(0.9),
              spreadRadius: 6,
              blurRadius: 5,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Attendance System",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "Login as",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => login(),
                      ));
                },
                child: CircleAvatar(
                  radius: 110,
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Icon(
                          Icons.person,
                          size: 100,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Admin",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(bottom: 10),
                child: Text(
                  "or",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => register(),
                      ));
                },
                child: CircleAvatar(
                  radius: 110,
                  child: Column(
                    children: [
                      Container(
                        height: 150,
                        width: 150,
                        child: Icon(
                          Icons.school_outlined,
                          size: 100,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text(
                          "Student",
                          style: TextStyle(fontSize: 30),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

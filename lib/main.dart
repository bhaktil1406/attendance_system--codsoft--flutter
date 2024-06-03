import 'package:attendance_system/AttendanceDataPage.dart';
import 'package:attendance_system/index.dart';
import 'package:attendance_system/loginpage.dart';
import 'package:attendance_system/register.dart';
import 'package:attendance_system/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: index(),
    );
  }
}

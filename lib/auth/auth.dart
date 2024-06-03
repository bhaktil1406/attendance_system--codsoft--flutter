import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class authService {
  Future<User?> createUserWithEmailAndPassword(
      String email, String password, BuildContext context) async {
    try {
      final cred = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("password is to weak")));
      }

      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("Email is already register")));
      }
      print("some thing wrong .............");
    }
    return null;
  }

  Future<User?> loginUserWithEmailAndPassword(
      String email, String password) async {
    try {
      final cred = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return cred.user;
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<User?> signout() async {
    try {
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      print(e);
    }
    return null;
  }

  Future<void> saveUser(
    String name,
    String email,
    String password,
    String id,
    String department,
    String sem,
    String uid,
  ) async {
    try {
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': name,
        'email': email,
        'password': password,
        'id': id,
        'department': department,
        'sem': sem,
        'uid': uid,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User data saved successfully");
    } catch (e) {
      print("Error saving user data: $e");
      throw e; // Re-throw the error to handle it in the calling function if necessary
    }
  }

  Future<void> saveUserData(
    String uid,
    DateTime date,
    String subject,
    bool isPresent,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('userData')
          .doc(uid)
          .collection('attendance')
          .add({
        'date': date,
        'subject': subject,
        'isPresent': isPresent,
        'createdAt': FieldValue.serverTimestamp(),
      });
      print("User data saved successfully");
    } catch (e) {
      print("Error saving user data: $e");
      throw e; // Re-throw the error to handle it in the calling function if necessary
    }
  }
}

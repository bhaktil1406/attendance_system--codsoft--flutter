import 'package:attendance_system/auth/auth.dart';
import 'package:attendance_system/register.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class homepage extends StatefulWidget {
  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage> {
  TextEditingController date = TextEditingController();
  TextEditingController subject = TextEditingController();

  int _selectedValue = 0;
  bool _isPresent = false;
  String dropdownvalue = 'os';

  // List of items in our dropdown menu
  var sub = [
    'os',
    'cn',
    'cd',
  ];

  @override
  Widget build(BuildContext context) {
    final uid = FirebaseAuth.instance.currentUser;

    Future<void> _selectDate() async {
      DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2100));

      if (picked != null) {
        setState(() {
          date.text = picked.toString().split(" ")[0];
        });
      }
    }

    void savedata() async {
      try {
        // Fetch the user document from the "users" collection
        DocumentSnapshot userDocument = await FirebaseFirestore.instance
            .collection('users')
            .doc(uid!.uid)
            .get();

        // Check if userDocument exists
        if (userDocument.exists) {
          // Create a new document in the "attendance" subcollection under the user document
          await FirebaseFirestore.instance
              .collection('users')
              .doc(uid!.uid)
              .collection('attendance')
              .add({
            'date': date.text,
            'subject': subject.text,
            'present': _isPresent,
          });
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Attendance record added successfully")));
          print('Attendance record added successfully');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("'User document does not exist")));
          print('User document does not exist');
        }
      } catch (e) {
        print('Error adding attendance record: $e');
      }
    }

    Future<void> viewAllUserData() async {
      try {
        // Query all documents from the "users" collection
        final querySnapshot =
            await FirebaseFirestore.instance.collection("users").get();

        if (querySnapshot.docs.isNotEmpty) {
          // Iterate through each document and access its data
          for (var doc in querySnapshot.docs) {
            // Access document data
            var userData = doc.data();
            // Print or process the user data
            print(userData);
          }
        } else {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("No user data found.")));
          print("No user data found.");
        }
      } catch (e) {
        print("Error: $e");
      }
    }

    void signoutt() async {
      await authService().signout();
      print("logout");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => register()));
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Logout successfully")));
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
            "Attendance System",
            style: TextStyle(
                color: Colors.purple,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      drawer: Drawer(
        child: GestureDetector(
          onTap: (() => signoutt()),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                child: Icon(Icons.logout),
              ),
              Container(
                  margin: EdgeInsets.only(right: 20),
                  child: Text(
                    "Signout",
                    style: TextStyle(fontSize: 20),
                  )),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Container(
                  child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .where("uid", isEqualTo: uid?.uid)
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return Text("error................");
                  }
                  if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                    final userData = snapshot.data!.docs.first;
                    final username = userData["name"];
                    final dep = userData["department"];
                    final sem = userData["sem"];
                    final id = userData["id"];
                    return Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            alignment: Alignment.topLeft,
                            child: Text(
                              "Welcome $username",
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                child: Text(
                                  "id: $id",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "semester: $sem",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              Container(
                                child: Text(
                                  "Department: $dep",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 45,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.purple.shade200,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextField(
                              controller: date,
                              decoration: InputDecoration(
                                  hintText: "Enter date here",
                                  prefixIcon: Icon(Icons.calendar_month),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none)),
                              readOnly: true,
                              onTap: () {
                                _selectDate();
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Container(
                            padding: EdgeInsets.all(5),
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Colors.purple.shade200,
                                borderRadius: BorderRadius.circular(30)),
                            child: TextField(
                              controller: subject,
                              decoration: InputDecoration(
                                hintText: "Enter your subject name",
                                prefixIcon: Icon(Icons.menu_book_sharp),
                                enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          padding: EdgeInsets.all(5),
                          child: Column(
                            children: <Widget>[
                              // Create a RadioListTile for option 1
                              RadioListTile(
                                hoverColor: Colors.purple,
                                activeColor: Colors.purple,
                                title: Text(
                                    'Present'), // Display the title for option 1
                                subtitle: Text(
                                    'Click here to mark present'), // Display a subtitle for option 1
                                value: 1, // Assign a value of 1 to this option
                                groupValue:
                                    _selectedValue, // Use _selectedValue to track the selected option
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue =
                                        value!; // Update _selectedValue when option 1 is selected
                                    _isPresent = value == 1;
                                  });
                                  print(_isPresent);
                                },
                              ),
                              RadioListTile(
                                activeColor: Colors.purple,
                                title: Text(
                                    'Absent'), // Display the title for option 1
                                subtitle: Text(
                                    'click here to mark absent'), // Display a subtitle for option 1
                                value: 2, // Assign a value of 1 to this option
                                groupValue:
                                    _selectedValue, // Use _selectedValue to track the selected option
                                onChanged: (value) {
                                  setState(() {
                                    _selectedValue =
                                        value!; // Update _selectedValue when option 1 is selected
                                    _isPresent = value == 1;
                                  });
                                  print(_isPresent);
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            savedata();
                            viewAllUserData();
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 20),
                            child: Container(
                              height: 50,
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.purple.shade200,
                                  borderRadius: BorderRadius.circular(30)),
                              child: Center(
                                child: Text(
                                  "Save",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: (() => signoutt()),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                child: Icon(Icons.logout),
                              ),
                              Container(
                                  margin: EdgeInsets.only(right: 20),
                                  child: Text(
                                    "Signout",
                                    style: TextStyle(fontSize: 20),
                                  )),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                  return Container();
                },
              )

                  // StreamBuilder<QuerySnapshot>(
                  //     stream: FirebaseFirestore.instance
                  //         .collection('users')
                  //         .snapshots(),
                  //     builder: (context, snapshot) {
                  //       List<Column> userwidgets = [];

                  //       if (snapshot.hasData) {
                  //         final user = snapshot.data?.docs.reversed.toList();

                  //         for (var u in user!) {
                  //           // final name = u.get('name');
                  //           // final dep = u.get('department');
                  //           // final sem = u.get('sem');
                  //           // final id = u.get('id');

                  //           final userwidget = Column(
                  //             crossAxisAlignment: CrossAxisAlignment.start,
                  //             children: [
                  //               Padding(
                  //                 padding:
                  //                     const EdgeInsets.symmetric(horizontal: 20),
                  //                 child: Container(
                  //                   child: Text(
                  //                     "welcome " + u['name'],
                  //                     style: TextStyle(fontSize: 30),
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 20,
                  //               ),
                  //               Row(
                  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //                 children: [
                  //                   Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 20),
                  //                     child: Container(
                  //                       child: Text(
                  //                         "id : " + u['id'],
                  //                         style: TextStyle(fontSize: 20),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 20),
                  //                     child: Container(
                  //                       child: Text(
                  //                         "Department : " + u['department'],
                  //                         style: TextStyle(fontSize: 20),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                   Padding(
                  //                     padding: const EdgeInsets.symmetric(
                  //                         horizontal: 20),
                  //                     child: Container(
                  //                       child: Text(
                  //                         "sem : " + u['sem'],
                  //                         style: TextStyle(fontSize: 20),
                  //                       ),
                  //                     ),
                  //                   ),
                  //                 ],
                  //               ),
                  //               SizedBox(
                  //                 height: 30,
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.symmetric(
                  //                   horizontal: 20,
                  //                 ),
                  //                 child: Container(
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.purple.shade200,
                  //                       borderRadius: BorderRadius.circular(30)),
                  //                   child: TextField(
                  //                     controller: date,
                  //                     decoration: InputDecoration(
                  //                         hintText: "Enter date here",
                  //                         prefixIcon: Icon(Icons.calendar_month),
                  //                         enabledBorder: OutlineInputBorder(
                  //                             borderSide: BorderSide.none),
                  //                         focusedBorder: OutlineInputBorder(
                  //                             borderSide: BorderSide.none)),
                  //                     readOnly: true,
                  //                     onTap: () {
                  //                       _selectDate();
                  //                     },
                  //                   ),
                  //                 ),
                  //               ),
                  //               SizedBox(
                  //                 height: 20,
                  //               ),
                  //               Padding(
                  //                 padding:
                  //                     const EdgeInsets.symmetric(horizontal: 20),
                  //                 child: Container(
                  //                   padding: EdgeInsets.all(5),
                  //                   width: double.infinity,
                  //                   decoration: BoxDecoration(
                  //                       color: Colors.purple.shade200,
                  //                       borderRadius: BorderRadius.circular(30)),
                  //                   child: DropdownButton(
                  //                     iconSize: 25,
                  //                     style: TextStyle(
                  //                         fontSize: 20, color: Colors.black87),
                  //                     value: dropdownvalue,

                  //                     // Down Arrow Icon
                  //                     icon: const Icon(Icons.keyboard_arrow_down),

                  //                     // Array list of items
                  //                     items: sub.map((String items) {
                  //                       return DropdownMenuItem(
                  //                         value: items,
                  //                         child: Text(items),
                  //                       );
                  //                     }).toList(),
                  //                     // After selecting the desired option,it will
                  //                     // change button value to selected value
                  //                     onChanged: (String? newValue) {
                  //                       setState(() {
                  //                         dropdownvalue = newValue!;
                  //                       });
                  //                     },
                  //                   ),
                  //                 ),
                  //               ),
                  //             ],
                  //           );
                  //           userwidgets.add(userwidget);
                  //         }
                  //       }
                  //       return Expanded(
                  //           child: ListView(
                  //         children: userwidgets,
                  //       ));
                  //     }),
                  ),
            ],
          ),
        ),
      ),
    );
  }
}

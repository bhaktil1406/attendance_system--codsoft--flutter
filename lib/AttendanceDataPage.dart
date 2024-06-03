import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AttendanceDataPage extends StatelessWidget {
  Future<List<Map<String, dynamic>>> fetchAllAttendanceData() async {
    List<Map<String, dynamic>> allData = [];
    try {
      QuerySnapshot userSnapshot =
          await FirebaseFirestore.instance.collection('users').get();

      for (var userDoc in userSnapshot.docs) {
        String userId = userDoc.id;
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

        QuerySnapshot attendanceSnapshot = await FirebaseFirestore.instance
            .collection('users')
            .doc(userId)
            .collection('attendance')
            .get();

        for (var attendanceDoc in attendanceSnapshot.docs) {
          Map<String, dynamic> attendanceData =
              attendanceDoc.data() as Map<String, dynamic>;
          allData.add({
            'userId': userId,
            'userData': userData,
            'attendanceData': attendanceData,
          });
        }
      }
    } catch (e) {
      print('Error fetching attendance data: $e');
    }
    return allData;
  }

  @override
  Widget build(BuildContext context) {
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
            "Attendance data",
            style: TextStyle(
                color: Colors.purple,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: fetchAllAttendanceData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No attendance data found'));
          } else {
            List<Map<String, dynamic>> allData = snapshot.data!;
            return ListView.builder(
              itemCount: allData.length,
              itemBuilder: (context, index) {
                var data = allData[index];
                return Card(
                  elevation: 4,
                  margin: EdgeInsets.all(15),
                  shadowColor: Colors.purple,
                  child: ListTile(
                    title: Text('User ID: ${data['userId']}'),
                    subtitle: Text(
                        'User Data: ${data['userData']}\nAttendance Data: ${data['attendanceData']}'),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

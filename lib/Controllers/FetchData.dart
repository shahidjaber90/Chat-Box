import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  late Map<String, dynamic> userData;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final data = await fetchUserData();
    setState(() {
      userData = data!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Data'),
      ),
      body: userData != null
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Username: ${userData['userName']}'),
                Text('Age: ${userData['age']}'),
                // Add more fields as needed
              ],
            )
          : CircularProgressIndicator(), // Display a loading indicator while fetching data
    );
  }
}




//

Future<Map<String, dynamic>?> fetchUserData() async {
  final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('users');

  // Fetch data from Firestore
  DocumentSnapshot userDoc =
      await usersCollection.doc('your_document_id').get();

  // Check if the document exists
  if (userDoc.exists) {
    // Convert Firestore data to a Map
    Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;

    // You can now access individual fields from the userData Map
    String username = userData['username'];
    int age = userData['age'];

    // Return the data as a Map
    return userData;
  } else {
    // Handle the case where the document doesn't exist
    return null;
  }
}

//


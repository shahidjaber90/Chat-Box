import 'package:chatbox/Utils/Colors.dart';
import 'package:chatbox/Widgets.dart/MyText.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  bool isObscure = true;
  bool isLoading = false;

  void obscureValue() {
    isObscure = !isObscure;
    notifyListeners();
  }

  // signup with email & password
  void signinUser(context, email, password) async {
    isLoading = true;
    notifyListeners();
    try {

      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
          
    isLoading = false;
    notifyListeners();
    } on FirebaseAuthException catch (e) {
    isLoading = false;
    notifyListeners();
      if (e.code == 'user-not-found') {
        showErrorMsg('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        showErrorMsg('Wrong password provided for that user.');
      }
    }
  }

  // show error msg

  showErrorMsg(String msg) {
    return ScaffoldMessenger(
      child: SnackBar(
        content: MyText(
          myText: msg,
          fontSize: 16,
          fontWeight: FontWeight.w500,
          textColor: ColorConstant.whiteColor,
        ),
        backgroundColor: Colors.red,
      ),
    );
  }

  // get user data
  getUserData(String? email) async {
    try {
      if (email != null && email.isNotEmpty) {
        DocumentSnapshot userSnapshot =
            await _firestore.collection('Users').doc(email).get();
        if (userSnapshot.exists) {
          return userSnapshot.data() as Map<String, dynamic>;
        } else {
          // User document does not exist
          return null;
        }
      } else {
        // Invalid UID
        return null;
      }
    } catch (e) {
      print('Error fetching user data: $e');
      return null;
    }
  }
}
